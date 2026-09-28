class CityLocation {
  final String name;
  final String country;
  final String countryCode;
  final String adminArea;
  final double latitude;
  final double longitude;
  final String climateZone;
  final String historicalTrend;
  final bool isVulnerabilityHotspot;

  const CityLocation({
    required this.name,
    required this.country,
    this.countryCode = '',
    this.adminArea = '',
    required this.latitude,
    required this.longitude,
    required this.climateZone,
    required this.historicalTrend,
    this.isVulnerabilityHotspot = false,
  });

  String get displayName => adminArea.isNotEmpty && adminArea != name
      ? '$name, $adminArea ($country)'
      : '$name, $country';

  factory CityLocation.fromGeocodingJson(Map<String, dynamic> json) {
    final lat = (json['latitude'] as num).toDouble();
    final lon = (json['longitude'] as num).toDouble();
    final name = json['name'] as String? ?? 'Unknown Location';
    final country = json['country'] as String? ?? '';
    final code = (json['country_code'] as String? ?? '').toUpperCase();
    final admin = json['admin1'] as String? ?? '';

    return CityLocation(
      name: name,
      country: country,
      countryCode: code,
      adminArea: admin,
      latitude: lat,
      longitude: lon,
      climateZone: _inferClimateZone(lat, code),
      historicalTrend: 'Hyperlocal real-time thermal monitoring',
      isVulnerabilityHotspot: _isKnownHotspot(code, lat),
    );
  }

  static String _inferClimateZone(double lat, String countryCode) {
    final absLat = lat.abs();
    if (absLat < 15) return 'Equatorial / Tropical Humid';
    if (absLat < 25) return 'Sub-Tropical / Sahelian Arid';
    if (absLat < 35) return 'Mediterranean / Arid Warm';
    if (absLat < 50) return 'Temperate / Continental';
    return 'Sub-Polar / Cool Temperate';
  }

  static bool _isKnownHotspot(String countryCode, double lat) {
    const hotspotCodes = {'EG', 'NG', 'PK', 'IN', 'SA', 'IQ', 'DZ', 'SL', 'CD'};
    return hotspotCodes.contains(countryCode.toUpperCase());
  }

  static const List<CityLocation> defaultAfricanCities = [
    CityLocation(
      name: 'Cairo',
      country: 'Egypt',
      countryCode: 'EG',
      latitude: 30.0444,
      longitude: 31.2357,
      climateZone: 'Arid / Desert Heat',
      historicalTrend: '>200 10-hour heat stress events / decade',
      isVulnerabilityHotspot: true,
    ),
    CityLocation(
      name: 'Riyadh',
      country: 'Saudi Arabia',
      countryCode: 'SA',
      latitude: 24.7136,
      longitude: 46.6753,
      climateZone: 'Hyper-Arid Desert',
      historicalTrend: 'Extreme Summer Radiance Corridor',
      isVulnerabilityHotspot: true,
    ),
    CityLocation(
      name: 'Lahore',
      country: 'Pakistan',
      countryCode: 'PK',
      latitude: 31.5204,
      longitude: 74.3587,
      climateZone: 'Semi-Arid Monsoon',
      historicalTrend: 'High Vulnerability Urban Heat Island',
      isVulnerabilityHotspot: true,
    ),
    CityLocation(
      name: 'Lagos',
      country: 'Nigeria',
      countryCode: 'NG',
      latitude: 6.5244,
      longitude: 3.3792,
      climateZone: 'Tropical Coastal Humidity',
      historicalTrend: 'CHEWS Early Warning Pilot Hub',
      isVulnerabilityHotspot: true,
    ),
    CityLocation(
      name: 'Dubai',
      country: 'United Arab Emirates',
      countryCode: 'AE',
      latitude: 25.2048,
      longitude: 55.2708,
      climateZone: 'Coastal Hyper-Arid',
      historicalTrend: 'High Direct Solar & Asphalt Radiation',
      isVulnerabilityHotspot: true,
    ),
    CityLocation(
      name: 'Nairobi',
      country: 'Kenya',
      countryCode: 'KE',
      latitude: -1.2921,
      longitude: 36.8219,
      climateZone: 'Sub-Tropical Highland',
      historicalTrend: 'Rapid equatorial urbanization hotspot',
    ),
    CityLocation(
      name: 'Madrid',
      country: 'Spain',
      countryCode: 'ES',
      latitude: 40.4168,
      longitude: -3.7038,
      climateZone: 'Mediterranean Continental',
      historicalTrend: 'European Heatwave Vulnerability Alert',
    ),
    CityLocation(
      name: 'Kano',
      country: 'Nigeria',
      countryCode: 'NG',
      latitude: 12.0022,
      longitude: 8.5920,
      climateZone: 'Sahelian Semi-Arid',
      historicalTrend: '>200 10-hour heat stress events / decade',
      isVulnerabilityHotspot: true,
    ),
    CityLocation(
      name: 'Alexandria',
      country: 'Egypt',
      countryCode: 'EG',
      latitude: 31.2001,
      longitude: 29.9187,
      climateZone: 'Mediterranean Coastal',
      historicalTrend: '+7.6 hrs/yr extreme heat stress increase',
      isVulnerabilityHotspot: true,
    ),
    CityLocation(
      name: 'Algiers',
      country: 'Algeria',
      countryCode: 'DZ',
      latitude: 36.7538,
      longitude: 3.0588,
      climateZone: 'Mediterranean Coastal',
      historicalTrend: '+4.6 hrs/yr extreme heat stress increase',
    ),
    CityLocation(
      name: 'Dakar',
      country: 'Senegal',
      countryCode: 'SN',
      latitude: 14.7167,
      longitude: -17.4677,
      climateZone: 'Atlantic Sahelian',
      historicalTrend: '+3.8 hrs/yr heat stress increase',
      isVulnerabilityHotspot: true,
    ),
    CityLocation(
      name: 'Johannesburg',
      country: 'South Africa',
      countryCode: 'ZA',
      latitude: -26.2041,
      longitude: 28.0473,
      climateZone: 'Subtropical Highland',
      historicalTrend: 'Southern Africa urban heat island',
    ),
  ];
}
