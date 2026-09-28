import 'package:geolocator/geolocator.dart';

/// Minimal result of a location lookup — includes a best-effort
/// "city" placeholder since geolocator only gives coordinates.
/// Swap in a reverse-geocoding package here if the backend later
/// needs a real city name rather than "lat,lon".
class DevicePosition {
  final double latitude;
  final double longitude;
  final String city;

  DevicePosition({required this.latitude, required this.longitude, required this.city});
}

class LocationService {
  Future<DevicePosition?> getCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    if (permission == LocationPermission.deniedForever) return null;

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.medium),
    );

    return DevicePosition(
      latitude: position.latitude,
      longitude: position.longitude,
      city: '${position.latitude.toStringAsFixed(2)},${position.longitude.toStringAsFixed(2)}',
    );
  }
}
