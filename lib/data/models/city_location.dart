class CityLocation {
  final String name;
  final String country;
  final double latitude;
  final double longitude;
  final String climateZone;
  final String historicalTrend;
  final bool isVulnerabilityHotspot;

  const CityLocation({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.climateZone,
    required this.historicalTrend,
    this.isVulnerabilityHotspot = false,
  });

  String get displayName => '$name, $country';

  static const List<CityLocation> defaultAfricanCities = [
    CityLocation(
      name: 'Cairo',
      country: 'Egypt',
      latitude: 30.0444,
      longitude: 31.2357,
      climateZone: 'Arid / Desert Heat',
      historicalTrend: '>200 10-hour heat stress events / decade',
      isVulnerabilityHotspot: true,
    ),
    CityLocation(
      name: 'Kano',
      country: 'Nigeria',
      latitude: 12.0022,
      longitude: 8.5920,
      climateZone: 'Sahelian Semi-Arid',
      historicalTrend: '>200 10-hour heat stress events / decade',
      isVulnerabilityHotspot: true,
    ),
    CityLocation(
      name: 'Lagos',
      country: 'Nigeria',
      latitude: 6.5244,
      longitude: 3.3792,
      climateZone: 'Tropical Coastal Humidity',
      historicalTrend: 'CHEWS Early Warning Pilot Hub',
      isVulnerabilityHotspot: true,
    ),
    CityLocation(
      name: 'Alexandria',
      country: 'Egypt',
      latitude: 31.2001,
      longitude: 29.9187,
      climateZone: 'Mediterranean Coastal',
      historicalTrend: '+7.6 hrs/yr extreme heat stress increase',
      isVulnerabilityHotspot: true,
    ),
    CityLocation(
      name: 'Algiers',
      country: 'Algeria',
      latitude: 36.7538,
      longitude: 3.0588,
      climateZone: 'Mediterranean Coastal',
      historicalTrend: '+4.6 hrs/yr extreme heat stress increase',
    ),
    CityLocation(
      name: 'Tunis',
      country: 'Tunisia',
      latitude: 36.8065,
      longitude: 10.1815,
      climateZone: 'North African Coastal',
      historicalTrend: '+4.2 hrs/yr extreme heat stress increase',
    ),
    CityLocation(
      name: 'Tripoli',
      country: 'Libya',
      latitude: 32.8872,
      longitude: 13.1913,
      climateZone: 'Coastal Mediterranean Arid',
      historicalTrend: '+3.4 hrs/yr heat stress increase',
    ),
    CityLocation(
      name: 'Dakar',
      country: 'Senegal',
      latitude: 14.7167,
      longitude: -17.4677,
      climateZone: 'Atlantic Sahelian',
      historicalTrend: '+3.8 hrs/yr heat stress increase',
      isVulnerabilityHotspot: true,
    ),
    CityLocation(
      name: 'Ibadan',
      country: 'Nigeria',
      latitude: 7.3775,
      longitude: 3.9470,
      climateZone: 'Tropical Wet & Dry',
      historicalTrend: '+2.8 hrs/yr heat stress increase',
    ),
    CityLocation(
      name: 'Kaduna',
      country: 'Nigeria',
      latitude: 10.5105,
      longitude: 7.4165,
      climateZone: 'Tropical Savanna',
      historicalTrend: '+2.6 hrs/yr heat stress increase',
    ),
    CityLocation(
      name: 'Freetown',
      country: 'Sierra Leone',
      latitude: 8.4840,
      longitude: -13.2299,
      climateZone: 'Tropical Monsoon',
      historicalTrend: "Africa's First Heat Action Plan (2025)",
      isVulnerabilityHotspot: true,
    ),
    CityLocation(
      name: 'Nairobi',
      country: 'Kenya',
      latitude: -1.2921,
      longitude: 36.8219,
      climateZone: 'Sub-Tropical Highland',
      historicalTrend: 'Rapid equatorial urbanization hotspot',
    ),
    CityLocation(
      name: 'Accra',
      country: 'Ghana',
      latitude: 5.6037,
      longitude: -0.1870,
      climateZone: 'Coastal Guinea Savanna',
      historicalTrend: 'High informal market worker density',
    ),
    CityLocation(
      name: 'Johannesburg',
      country: 'South Africa',
      latitude: -26.2041,
      longitude: 28.0473,
      climateZone: 'Subtropical Highland',
      historicalTrend: 'Southern Africa urban heat island',
    ),
    CityLocation(
      name: 'Kinshasa',
      country: 'DR Congo',
      latitude: -4.4419,
      longitude: 15.2663,
      climateZone: 'Tropical Wet / Megacity',
      historicalTrend: 'High density informal settlement zone',
      isVulnerabilityHotspot: true,
    ),
  ];
}
