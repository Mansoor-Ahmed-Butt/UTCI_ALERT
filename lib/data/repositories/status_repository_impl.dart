import '../../core/errors/failure.dart';
import '../../core/utils/result.dart';
import '../../domain/repositories/status_repository.dart';
import '../datasources/backend_remote_datasource.dart';
import '../datasources/hive_local_datasource.dart';
import '../datasources/weather_remote_datasource.dart';
import '../models/city_location.dart';
import '../models/utci_status_model.dart';

class StatusRepositoryImpl implements StatusRepository {
  final BackendRemoteDataSource _remote;
  final HiveLocalDataSource _local;
  final WeatherRemoteDataSource? _weatherRemote;

  StatusRepositoryImpl(this._remote, this._local, [this._weatherRemote]);

  @override
  Future<Result<bool>> registerDevice({
    required String fcmToken,
    required String city,
    required double lat,
    required double lon,
    required String profile,
  }) async {
    try {
      await _remote.registerDevice(
        fcmToken: fcmToken,
        city: city,
        lat: lat,
        lon: lon,
        profile: profile,
      );
      return Result.success(true);
    } catch (e) {
      return Result.failure(Failure.network(e));
    }
  }

  @override
  UtciStatusModel? get cachedStatus => _local.cachedStatus;

  @override
  Future<Result<UtciStatusModel>> refreshStatus({required String city}) async {
    try {
      final status = await _remote.fetchStatus(city: city);
      await cacheStatus(status);
      return Result.success(status);
    } catch (_) {
      // If custom Node backend is unreachable, gracefully compute from live weather API
      if (_weatherRemote != null) {
        try {
          final matchedCity = CityLocation.defaultAfricanCities.firstWhere(
            (c) => c.name.toLowerCase() == city.toLowerCase(),
            orElse: () => CityLocation.defaultAfricanCities.first,
          );
          final weather = await _weatherRemote.fetchCurrentWeather(
            lat: matchedCity.latitude,
            lon: matchedCity.longitude,
            cityName: matchedCity.name,
          );
          final freshStatus = UtciStatusModel(
            category: weather.utciCategory,
            value: weather.calculatedUtci,
            city: city,
            updatedAt: DateTime.now(),
            suggestion: 'Current heat status for $city: ${weather.categoryLabel}',
          );
          await cacheStatus(freshStatus);
          return Result.success(freshStatus);
        } catch (_) {}
      }

      // Offline fallback: return cached status if available
      final cached = _local.cachedStatus;
      if (cached != null) return Result.success(cached);

      return Result.failure(const Failure('Unable to reach server.'));
    }
  }

  @override
  Future<void> cacheStatus(UtciStatusModel status) => _local.saveStatus(status);
}
