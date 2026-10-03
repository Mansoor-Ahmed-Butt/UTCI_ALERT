import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../data/models/city_location.dart';

class GeofenceStatus {
  final bool isInsideDangerZone;
  final String cityName;
  final double userLatitude;
  final double userLongitude;
  final double centerLatitude;
  final double centerLongitude;
  final double radiusKm;
  final double distanceToCenterKm;
  final double localUtci;
  final double thresholdUtci;
  final DateTime lastUpdated;

  const GeofenceStatus({
    required this.isInsideDangerZone,
    this.cityName = '',
    required this.userLatitude,
    required this.userLongitude,
    required this.centerLatitude,
    required this.centerLongitude,
    required this.radiusKm,
    required this.distanceToCenterKm,
    required this.localUtci,
    required this.thresholdUtci,
    required this.lastUpdated,
  });

  String get badgeLabel => isInsideDangerZone ? 'geofence_alert'.tr : 'geofence_safe_perimeter'.tr;

  String get zoneTitle {
    if (cityName.isEmpty) return 'geofence_standard_perimeter'.tr;
    if (isInsideDangerZone) {
      return 'geofence_zone_danger'.trParams({'city': cityName});
    } else if (localUtci >= thresholdUtci) {
      return 'geofence_zone_regional'.trParams({'city': cityName});
    } else {
      return 'geofence_zone_safe'.trParams({'city': cityName});
    }
  }

  String get statusSummary {
    if (cityName.isEmpty) return 'geofence_standard_summary'.tr;
    if (isInsideDangerZone) {
      return 'geofence_critical_active'.trParams({
        'lat': userLatitude.toStringAsFixed(2),
        'lon': userLongitude.toStringAsFixed(2),
        'radius': radiusKm.toInt().toString(),
        'utci': localUtci.toStringAsFixed(1),
      });
    } else if (localUtci >= thresholdUtci) {
      return 'geofence_regional_heatwave'.trParams({
        'utci': localUtci.toStringAsFixed(1),
        'dist': distanceToCenterKm.toStringAsFixed(1),
      });
    } else {
      return 'geofence_safe_zone'.trParams({
        'utci': localUtci.toStringAsFixed(1),
      });
    }
  }
}

class GeofencingService extends GetxService {
  final Rx<GeofenceStatus> geofenceStatus = Rx<GeofenceStatus>(
    GeofenceStatus(
      isInsideDangerZone: false,
      cityName: 'Cairo',
      userLatitude: 30.0444,
      userLongitude: 31.2357,
      centerLatitude: 30.0444,
      centerLongitude: 31.2357,
      radiusKm: 25.0,
      distanceToCenterKm: 0.0,
      localUtci: 32.0,
      thresholdUtci: 38.0,
      lastUpdated: DateTime.now(),
    ),
  );

  final RxBool isMonitoring = true.obs;

  /// Haversine Formula to compute accurate spherical distance in kilometers between two GPS coordinates
  static double calculateDistanceKm({
    required double lat1,
    required double lon1,
    required double lat2,
    required double lon2,
  }) {
    const earthRadiusKm = 6371.0;
    final dLat = _degToRad(lat2 - lat1);
    final dLon = _degToRad(lon2 - lon1);

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degToRad(lat1)) *
            math.cos(_degToRad(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusKm * c;
  }

  static double _degToRad(double deg) => deg * (math.pi / 180.0);

  /// Evaluates thermal geofence status for the user's active coordinates and UTCI level
  void evaluateLocation({
    required double userLat,
    required double userLon,
    required CityLocation activeCity,
    required double currentUtci,
  }) {
    const dangerThreshold = 38.0; // UTCI >= 38 is Very Strong / Extreme Heat
    const geofenceRadiusKm = 25.0; // 25km bioclimatic risk radius

    final distanceToCityCenter = calculateDistanceKm(
      lat1: userLat,
      lon1: userLon,
      lat2: activeCity.latitude,
      lon2: activeCity.longitude,
    );

    final isWithinPerimeter = distanceToCityCenter <= geofenceRadiusKm;
    final isDangerLevel = currentUtci >= dangerThreshold;
    final isInsideActiveGeofence = isWithinPerimeter && isDangerLevel;

    geofenceStatus.value = GeofenceStatus(
      isInsideDangerZone: isInsideActiveGeofence,
      cityName: activeCity.name,
      userLatitude: userLat,
      userLongitude: userLon,
      centerLatitude: activeCity.latitude,
      centerLongitude: activeCity.longitude,
      radiusKm: geofenceRadiusKm,
      distanceToCenterKm: distanceToCityCenter,
      localUtci: currentUtci,
      thresholdUtci: dangerThreshold,
      lastUpdated: DateTime.now(),
    );

    debugPrint('Geofencing updated: ${activeCity.name} - Inside danger: $isInsideActiveGeofence');
  }
}
