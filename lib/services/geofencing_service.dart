import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../data/models/city_location.dart';

class GeofenceStatus {
  final bool isInsideDangerZone;
  final String zoneTitle;
  final double userLatitude;
  final double userLongitude;
  final double centerLatitude;
  final double centerLongitude;
  final double radiusKm;
  final double distanceToCenterKm;
  final double localUtci;
  final double thresholdUtci;
  final String statusSummary;
  final DateTime lastUpdated;

  const GeofenceStatus({
    required this.isInsideDangerZone,
    required this.zoneTitle,
    required this.userLatitude,
    required this.userLongitude,
    required this.centerLatitude,
    required this.centerLongitude,
    required this.radiusKm,
    required this.distanceToCenterKm,
    required this.localUtci,
    required this.thresholdUtci,
    required this.statusSummary,
    required this.lastUpdated,
  });

  String get badgeLabel => isInsideDangerZone ? 'GEOFENCE ALERT' : 'SAFE PERIMETER';
}

class GeofencingService extends GetxService {
  final Rx<GeofenceStatus> geofenceStatus = Rx<GeofenceStatus>(
    GeofenceStatus(
      isInsideDangerZone: false,
      zoneTitle: 'Standard Thermal Perimeter',
      userLatitude: 30.0444,
      userLongitude: 31.2357,
      centerLatitude: 30.0444,
      centerLongitude: 31.2357,
      radiusKm: 25.0,
      distanceToCenterKm: 0.0,
      localUtci: 32.0,
      thresholdUtci: 38.0,
      statusSummary: 'Normal thermal boundary. No active heat stress geofence triggers.',
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

    String summary;
    String zoneName;

    if (isInsideActiveGeofence) {
      zoneName = '${activeCity.name} Severe Heat Geofence';
      summary =
          'CRITICAL GEOFENCE ACTIVE: Your location (${userLat.toStringAsFixed(2)}°, ${userLon.toStringAsFixed(2)}°) is within the ${geofenceRadiusKm.toInt()}km danger perimeter where UTCI (${currentUtci.toStringAsFixed(1)}°C) exceeds safety threshold (38°C).';
    } else if (isDangerLevel) {
      zoneName = '${activeCity.name} Regional Heatwave';
      summary =
          'Regional heatwave detected (${currentUtci.toStringAsFixed(1)}°C UTCI). Distance to focal center: ${distanceToCityCenter.toStringAsFixed(1)} km.';
    } else {
      zoneName = '${activeCity.name} Safe Thermal Perimeter';
      summary =
          'You are in a safe bioclimatic zone. Local UTCI is ${currentUtci.toStringAsFixed(1)}°C (well below 38°C danger threshold).';
    }

    geofenceStatus.value = GeofenceStatus(
      isInsideDangerZone: isInsideActiveGeofence,
      zoneTitle: zoneName,
      userLatitude: userLat,
      userLongitude: userLon,
      centerLatitude: activeCity.latitude,
      centerLongitude: activeCity.longitude,
      radiusKm: geofenceRadiusKm,
      distanceToCenterKm: distanceToCityCenter,
      localUtci: currentUtci,
      thresholdUtci: dangerThreshold,
      statusSummary: summary,
      lastUpdated: DateTime.now(),
    );

    debugPrint('Geofencing updated: $zoneName - Inside danger: $isInsideActiveGeofence');
  }
}
