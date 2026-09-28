import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../data/datasources/weather_remote_datasource.dart';
import '../../data/models/weather_models.dart';
import '../../services/tts_service.dart';
import 'dashboard_controller.dart';

class ForecastController extends GetxController {
  final WeatherRemoteDataSource _weatherRemote;
  final TtsService _tts;

  ForecastController({
    required WeatherRemoteDataSource weatherRemote,
    required TtsService tts,
  })  : _weatherRemote = weatherRemote,
        _tts = tts;

  final RxList<HourlyUtciPoint> hourlyList = <HourlyUtciPoint>[].obs;
  final RxList<DailyUtciForecast> dailyList = <DailyUtciForecast>[].obs;
  final Rxn<SafeWorkWindows> safeWindows = Rxn<SafeWorkWindows>();
  final RxBool isLoading = false.obs;

  DashboardController get _dashboard => Get.find<DashboardController>();

  @override
  void onInit() {
    super.onInit();
    // Reactively refresh forecast when selected city changes in dashboard
    ever(_dashboard.selectedCity, (_) => loadForecast());
    loadForecast();
  }

  Future<void> loadForecast() async {
    isLoading.value = true;
    try {
      final city = _dashboard.selectedCity.value;
      final hourly = await _weatherRemote.fetchHourlyForecast(
        lat: city.latitude,
        lon: city.longitude,
      );
      final daily = await _weatherRemote.fetchDailyForecast(
        lat: city.latitude,
        lon: city.longitude,
      );

      hourlyList.assignAll(hourly);
      dailyList.assignAll(daily);
      safeWindows.value = _weatherRemote.calculateSafeWindows(hourly);
    } catch (e) {
      debugPrint('Forecast load error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> readForecastAloud() async {
    final sw = safeWindows.value;
    final city = _dashboard.selectedCity.value.name;

    if (sw == null) return;

    final text =
        'Heat stress forecast for $city. Safe outdoor working window is ${sw.morningWindow} in the morning, and ${sw.eveningWindow} in the evening. Peak danger period is ${sw.dangerWindow}. ${sw.recommendation}';

    await _tts.speak(text);
  }
}
