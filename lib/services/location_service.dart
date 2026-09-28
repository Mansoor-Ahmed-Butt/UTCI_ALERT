import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class DevicePosition {
  final double latitude;
  final double longitude;
  final String city;
  final String country;
  final String countryCode;
  final String state;
  final String fullDisplayName;

  const DevicePosition({
    required this.latitude,
    required this.longitude,
    required this.city,
    this.country = '',
    this.countryCode = '',
    this.state = '',
    this.fullDisplayName = '',
  });
}

class LocationService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 8),
      receiveTimeout: const Duration(seconds: 8),
      headers: {
        'User-Agent': 'UTCIAlertApp/1.0 (thermal.safety@open-heat.org)',
      },
    ),
  );

  Future<DevicePosition?> getCurrentPosition({bool performReverseGeocoding = true}) async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('Location services are disabled on device.');
        return null;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permission denied by user.');
          return null;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        debugPrint('Location permission permanently denied.');
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      String city = 'Current Location';
      String country = '';
      String countryCode = '';
      String state = '';

      if (performReverseGeocoding) {
        final geocoded = await _reverseGeocode(position.latitude, position.longitude);
        if (geocoded != null) {
          city = geocoded['city'] ?? city;
          country = geocoded['country'] ?? '';
          countryCode = geocoded['countryCode'] ?? '';
          state = geocoded['state'] ?? '';
        }
      }

      final displayName = country.isNotEmpty
          ? (state.isNotEmpty && state != city ? '$city, $state ($country)' : '$city, $country')
          : '$city (${position.latitude.toStringAsFixed(2)}°, ${position.longitude.toStringAsFixed(2)}°)';

      return DevicePosition(
        latitude: position.latitude,
        longitude: position.longitude,
        city: city,
        country: country,
        countryCode: countryCode,
        state: state,
        fullDisplayName: displayName,
      );
    } catch (e) {
      debugPrint('Location lookup exception: $e');
      return null;
    }
  }

  Future<Map<String, String>?> _reverseGeocode(double lat, double lon) async {
    // Primary: BigDataCloud reverse-geocode-client (Free, fast, no API key needed)
    try {
      final response = await _dio.get(
        'https://api.bigdatacloud.net/data/reverse-geocode-client',
        queryParameters: {
          'latitude': lat,
          'longitude': lon,
          'localityLanguage': 'en',
        },
      );

      if (response.statusCode == 200 && response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        final city = (data['city'] as String?)?.trim();
        final locality = (data['locality'] as String?)?.trim();
        final country = (data['countryName'] as String?)?.trim() ?? '';
        final countryCode = (data['countryCode'] as String?)?.trim().toUpperCase() ?? '';
        final state = (data['principalSubdivision'] as String?)?.trim() ?? '';

        final chosenCity = (city != null && city.isNotEmpty)
            ? city
            : ((locality != null && locality.isNotEmpty) ? locality : 'Detected Area');

        return {
          'city': chosenCity,
          'country': country,
          'countryCode': countryCode,
          'state': state,
        };
      }
    } catch (e) {
      debugPrint('BigDataCloud reverse geocode error: $e. Trying fallback...');
    }

    // Fallback: OpenStreetMap Nominatim
    try {
      final response = await _dio.get(
        'https://nominatim.openstreetmap.org/reverse',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'format': 'json',
        },
      );

      if (response.statusCode == 200 && response.data is Map) {
        final data = response.data as Map<String, dynamic>;
        final address = data['address'] as Map<String, dynamic>? ?? {};

        final city = (address['city'] ??
                address['town'] ??
                address['village'] ??
                address['suburb'] ??
                address['county']) as String? ??
            'Detected Area';
        final country = (address['country'] as String?) ?? '';
        final countryCode = (address['country_code'] as String?)?.toUpperCase() ?? '';
        final state = (address['state'] as String?) ?? '';

        return {
          'city': city,
          'country': country,
          'countryCode': countryCode,
          'state': state,
        };
      }
    } catch (e) {
      debugPrint('Nominatim reverse geocode fallback error: $e');
    }

    return null;
  }
}
