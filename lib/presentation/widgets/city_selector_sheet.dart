import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../data/datasources/weather_remote_datasource.dart';
import '../../data/models/city_location.dart';
import '../../services/native_language_service.dart';

class CitySelectorSheet extends StatefulWidget {
  final CityLocation currentCity;
  final ValueChanged<CityLocation> onCitySelected;
  final Future<void> Function() onUseGps;

  const CitySelectorSheet({
    super.key,
    required this.currentCity,
    required this.onCitySelected,
    required this.onUseGps,
  });

  @override
  State<CitySelectorSheet> createState() => _CitySelectorSheetState();
}

class _CitySelectorSheetState extends State<CitySelectorSheet> {
  final TextEditingController _searchController = TextEditingController();
  final WeatherRemoteDataSource _weatherRemote = Get.find<WeatherRemoteDataSource>();
  final NativeLanguageService _langService = Get.find<NativeLanguageService>();

  Timer? _debounceTimer;
  bool _isSearchingWorldwide = false;
  bool _isLocatingGps = false;
  List<CityLocation> _displayedCities = CityLocation.defaultAfricanCities;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      setState(() {
        _isSearchingWorldwide = false;
        _displayedCities = CityLocation.defaultAfricanCities;
      });
      return;
    }

    if (query.length < 2) {
      // Local filter on default hubs
      setState(() {
        _isSearchingWorldwide = false;
        _displayedCities = CityLocation.defaultAfricanCities
            .where((c) =>
                c.name.toLowerCase().contains(query.toLowerCase()) ||
                c.country.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 380), () async {
      setState(() => _isSearchingWorldwide = true);
      try {
        final results = await _weatherRemote.searchCities(query);
        if (mounted) {
          setState(() {
            _isSearchingWorldwide = false;
            if (results.isNotEmpty) {
              _displayedCities = results;
            } else {
              // Fallback to local filter
              _displayedCities = CityLocation.defaultAfricanCities
                  .where((c) =>
                      c.name.toLowerCase().contains(query.toLowerCase()) ||
                      c.country.toLowerCase().contains(query.toLowerCase()))
                  .toList();
            }
          });
        }
      } catch (_) {
        if (mounted) {
          setState(() => _isSearchingWorldwide = false);
        }
      }
    });
  }

  Future<void> _handleGpsTap() async {
    setState(() => _isLocatingGps = true);
    try {
      await widget.onUseGps();
      if (mounted) {
        Navigator.pop(context);
      }
    } finally {
      if (mounted) {
        setState(() => _isLocatingGps = false);
      }
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: MediaQuery.of(context).size.height * 0.82,
      padding: const EdgeInsets.only(top: 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF13171F) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: isDark ? Colors.white24 : Colors.black12,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select City or Region',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Worldwide Geocoding & Hyperlocal GPS',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white54 : Colors.black45,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // GPS Auto-detect Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: _isLocatingGps ? null : _handleGpsTap,
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.accent.withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _isLocatingGps
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black87),
                            )
                          : const Icon(Icons.my_location, color: Colors.black87, size: 18),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Use Exact GPS Location & Geofence',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                          ),
                          Text(
                            _isLocatingGps
                                ? 'Pinpointing high-accuracy GPS & locality...'
                                : 'Auto-detects real city, danger perimeter & native voice',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? Colors.white60 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 13, color: AppColors.accent),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Search Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search any city worldwide (e.g. Cairo, Riyadh, Lahore, Madrid)...',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white38 : Colors.black38,
                ),
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _isSearchingWorldwide
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.accent),
                        ),
                      )
                    : (_searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () => _searchController.clear(),
                          )
                        : null),
                filled: true,
                fillColor: isDark ? const Color(0xFF1E2430) : const Color(0xFFF1F3F6),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Result section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _searchController.text.isEmpty ? 'Featured Global Hubs' : 'Search Results',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                ),
                Text(
                  '${_displayedCities.length} locations',
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? Colors.white38 : Colors.black38,
                  ),
                ),
              ],
            ),
          ),

          // Cities List
          Expanded(
            child: _displayedCities.isEmpty
                ? Center(
                    child: Text(
                      'No matching cities found. Try another city name.',
                      style: TextStyle(fontSize: 13, color: isDark ? Colors.white38 : Colors.black38),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    itemCount: _displayedCities.length,
                    separatorBuilder: (_, __) => Divider(
                      color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
                      height: 1,
                    ),
                    itemBuilder: (context, index) {
                      final city = _displayedCities[index];
                      final isSelected = city.name.toLowerCase() == widget.currentCity.name.toLowerCase() &&
                          (city.country.isEmpty || city.country.toLowerCase() == widget.currentCity.country.toLowerCase());

                      final detectedLang = _langService.detectLanguageFromCountry(city.country, city.countryCode);

                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.accent
                                : (isDark ? const Color(0xFF232A36) : const Color(0xFFEEF1F5)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.location_city,
                            size: 19,
                            color: isSelected ? Colors.black87 : (isDark ? Colors.white70 : Colors.black87),
                          ),
                        ),
                        title: Row(
                          children: [
                            Flexible(
                              child: Text(
                                city.displayName,
                                style: TextStyle(
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                  fontSize: 13.5,
                                  color: isSelected ? AppColors.accent : null,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF262E3D) : const Color(0xFFE2E6EE),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '${detectedLang.flag} ${detectedLang.nativeName}',
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              '${city.latitude.toStringAsFixed(2)}°, ${city.longitude.toStringAsFixed(2)}°',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? Colors.white38 : Colors.black45,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '· ${city.climateZone}',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? Colors.white54 : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle, color: AppColors.accent, size: 20)
                            : null,
                        onTap: () {
                          Navigator.pop(context);
                          widget.onCitySelected(city);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
