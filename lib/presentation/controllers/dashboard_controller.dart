import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/utci_calculator.dart';
import '../../data/datasources/weather_remote_datasource.dart';
import '../../data/models/app_user_model.dart';
import '../../data/models/city_location.dart';
import '../../data/models/user_role.dart';
import '../../data/models/utci_status_model.dart';
import '../../data/models/weather_models.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/status_repository.dart';
import '../../domain/services/ai_heat_advisor_service.dart';
import '../../services/location_service.dart';
import '../../services/notification_service.dart';
import '../../services/tts_service.dart';

class DashboardController extends GetxController {
  final StatusRepository _statusRepository;
  final AuthRepository _authRepository;
  final NotificationService _notificationService;
  final LocationService _locationService;
  final WeatherRemoteDataSource _weatherRemote;
  final AiHeatAdvisorService _aiAdvisor;
  final TtsService _tts;

  DashboardController({
    required StatusRepository statusRepository,
    required AuthRepository authRepository,
    required NotificationService notificationService,
    required LocationService locationService,
    required WeatherRemoteDataSource weatherRemote,
    required AiHeatAdvisorService aiAdvisor,
    required TtsService tts,
  })  : _statusRepository = statusRepository,
        _authRepository = authRepository,
        _notificationService = notificationService,
        _locationService = locationService,
        _weatherRemote = weatherRemote,
        _aiAdvisor = aiAdvisor,
        _tts = tts;

  final Rx<CityLocation> selectedCity =
      Rx<CityLocation>(CityLocation.defaultAfricanCities.first);
  final Rx<UserRole> activeRole = Rx<UserRole>(UserRole.outdoorWorker);
  final Rxn<UtciStatusModel> status = Rxn<UtciStatusModel>();
  final Rxn<CurrentWeatherData> weather = Rxn<CurrentWeatherData>();
  final RxList<HourlyUtciPoint> hourlyPoints = <HourlyUtciPoint>[].obs;
  final Rxn<DynamicAdviceResult> dynamicAdvice = Rxn<DynamicAdviceResult>();
  final RxBool isRefreshing = false.obs;

  AppUserModel? get user => _authRepository.cachedUser;

  @override
  void onInit() {
    super.onInit();

    // Initialize role from cached user or fallback to Outdoor Worker
    if (user != null) {
      activeRole.value = user!.role;
    }

    // Load cached status immediately (offline first)
    status.value = _statusRepository.cachedStatus;
    if (status.value != null) {
      _updateAdvice();
    }

    _notificationService.listen(onAlert: _onAlert);

    // Initial weather & UTCI fetch
    refreshData();
  }

  Future<void> refreshData() async {
    isRefreshing.value = true;
    try {
      final city = selectedCity.value;
      final currentWeather = await _weatherRemote.fetchCurrentWeather(
        lat: city.latitude,
        lon: city.longitude,
        cityName: city.name,
      );
      weather.value = currentWeather;

      // Update status model
      final newStatus = UtciStatusModel(
        category: currentWeather.utciCategory,
        value: currentWeather.calculatedUtci,
        city: city.displayName,
        updatedAt: DateTime.now(),
        suggestion: UtciCalculator.getPlainLanguageWarning(
          category: currentWeather.utciCategory,
          role: activeRole.value,
        ),
      );

      status.value = newStatus;
      await _statusRepository.cacheStatus(newStatus);

      // Hourly forecast for mini-curve
      final hourly = await _weatherRemote.fetchHourlyForecast(
        lat: city.latitude,
        lon: city.longitude,
      );
      hourlyPoints.assignAll(hourly);

      _updateAdvice();
    } catch (e) {
      debugPrint('Error refreshing dashboard: $e');
    } finally {
      isRefreshing.value = false;
    }
  }

  void selectCity(CityLocation city) {
    selectedCity.value = city;
    refreshData();
  }

  Future<void> useGpsLocation() async {
    isRefreshing.value = true;
    try {
      final pos = await _locationService.getCurrentPosition();
      if (pos != null) {
        final gpsCity = CityLocation(
          name: 'Current Location',
          country: '${pos.latitude.toStringAsFixed(2)}°, ${pos.longitude.toStringAsFixed(2)}°',
          latitude: pos.latitude,
          longitude: pos.longitude,
          climateZone: 'Local GPS Coordinates',
          historicalTrend: 'Hyperlocal real-time assessment',
        );
        selectedCity.value = gpsCity;
        await refreshData();
      }
    } catch (_) {}
    isRefreshing.value = false;
  }

  void selectRole(UserRole role) {
    activeRole.value = role;
    _updateAdvice();
  }

  void _updateAdvice() {
    if (status.value == null) return;
    dynamicAdvice.value = _aiAdvisor.generateDynamicAdvice(
      status: status.value!,
      role: activeRole.value,
      weather: weather.value,
    );
  }

  void _onAlert(String category, String? suggestion) {
    if (status.value != null) {
      status.value = UtciStatusModel(
        category: category,
        value: status.value!.value,
        city: status.value!.city,
        updatedAt: DateTime.now(),
        suggestion: suggestion,
      );
      _statusRepository.cacheStatus(status.value!);
      _updateAdvice();
    }
  }

  Future<void> readAlertAloud() async {
    if (status.value == null) return;
    final advice = dynamicAdvice.value;
    final text = advice != null
        ? advice.toSpeechString()
        : 'UTCI Alert for ${selectedCity.value.displayName}: ${status.value!.categoryLabel}, ${status.value!.value.toStringAsFixed(1)} degrees. ${status.value!.suggestion ?? ''}';

    await _tts.speak(text);
  }
}
