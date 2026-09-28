import 'package:flutter/material.dart';

enum UserRole {
  outdoorWorker(
    'outdoor_worker',
    'Outdoor Worker',
    'Construction, street vendors & field laborers exposed to direct sun',
    Icons.construction,
  ),
  deliveryRider(
    'delivery_rider',
    'Delivery Rider',
    'Motorbike & bicycle couriers facing asphalt heat & helmet buildup',
    Icons.two_wheeler,
  ),
  farmer(
    'farmer',
    'Farmer',
    'Agricultural workers managing crop harvesting & livestock in peak heat',
    Icons.agriculture,
  ),
  informalResident(
    'informal_resident',
    'Informal Settlement',
    'Residents in high-density areas with corrugated tin roofing & limited shade',
    Icons.holiday_village_outlined,
  ),
  vulnerable(
    'vulnerable',
    'Elderly & Vulnerable',
    'Individuals with hypertension, respiratory risks, children & elderly',
    Icons.healing_outlined,
  );

  /// Matches the `profile` string the backend expects in POST /register.
  final String backendKey;
  final String label;
  final String description;
  final IconData icon;

  const UserRole(this.backendKey, this.label, this.description, this.icon);

  static UserRole fromBackendKey(String key) =>
      UserRole.values.firstWhere(
        (r) => r.backendKey == key,
        orElse: () => UserRole.outdoorWorker,
      );
}

extension UserRoleX on UserRole {
  static UserRole fromBackendKey(String key) => UserRole.fromBackendKey(key);
}
