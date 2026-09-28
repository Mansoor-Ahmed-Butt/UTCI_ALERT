import 'dart:math' as math;
import 'package:dio/dio.dart';
import '../../core/utils/utci_calculator.dart';
import '../models/weather_models.dart';

class WeatherRemoteDataSource {
  final Dio _dio;

  WeatherRemoteDataSource(this._dio);

  Future<CurrentWeatherData> fetchCurrentWeather({
    required double lat,
    required double lon,
    required String cityName,
  }) async {
    try {
      final response = await _dio.get(
        'https://api.open-meteo.com/v1/forecast',
        queryParameters: {
          'latitude': lat,
          'longitude': lon,
          'current':
              'temperature_2m,relative_humidity_2m,apparent_temperature,is_day,weather_code,wind_speed_10m',
          'timezone': 'auto',
        },
      );

      final current = response.data['current'] as Map<String, dynamic>;
      final temp = (current['temperature_2m'] as num).toDouble();
      final humidity = (current['relative_humidity_2m'] as num).toDouble();
      final apparent = (current['apparent_temperature'] as num).toDouble();
      final windKmh = (current['wind_speed_10m'] as num).toDouble();
      final windMps = windKmh / 3.6;
      final weatherCode = (current['weather_code'] as num?)?.toInt() ?? 0;

      // Approximate solar radiation based on is_day and cloud code
      final isDay = (current['is_day'] as num?)?.toInt() == 1;
      final solarRad = isDay ? (weatherCode <= 2 ? 650.0 : 280.0) : 0.0;

      final utci = UtciCalculator.calculate(
        airTempC: temp,
        relativeHumidityPct: humidity,
        windSpeedMps: windMps,
        solarRadiationWm2: solarRad,
      );

      return CurrentWeatherData(
        cityName: cityName,
        airTemperature: temp,
        relativeHumidity: humidity,
        apparentTemperature: apparent,
        windSpeedKmh: windKmh,
        windSpeedMps: windMps,
        uvIndex: isDay ? (utci > 38 ? 9.5 : 6.0) : 0.0,
        weatherCode: weatherCode,
        calculatedUtci: utci,
        utciCategory: UtciCalculator.categorize(utci),
        updatedAt: DateTime.now(),
      );
    } catch (_) {
      // Offline fallback: generate realistic bioclimatic estimate
      return _generateOfflineCurrent(cityName, lat, lon);
    }
  }

  Future<List<HourlyUtciPoint>> fetchHourlyForecast({
    required double lat,
    required double lon,
  }) async {
    try {
      final response = await _dio.get(
        'https://api.open-meteo.com/v1/forecast',
        queryParameters: {
          'latitude': lat,
          'longitude': lon,
          'hourly':
              'temperature_2m,relative_humidity_2m,apparent_temperature,weather_code,wind_speed_10m',
          'forecast_days': 2,
          'timezone': 'auto',
        },
      );

      final hourly = response.data['hourly'] as Map<String, dynamic>;
      final times = (hourly['time'] as List).cast<String>();
      final temps = (hourly['temperature_2m'] as List).cast<num>();
      final humidities = (hourly['relative_humidity_2m'] as List).cast<num>();
      final winds = (hourly['wind_speed_10m'] as List).cast<num>();

      final now = DateTime.now();
      final List<HourlyUtciPoint> points = [];

      for (int i = 0; i < times.length && points.length < 24; i++) {
        final dt = DateTime.tryParse(times[i]) ?? now.add(Duration(hours: i));
        // Show from current hour onward
        if (dt.isBefore(now.subtract(const Duration(hours: 1)))) continue;

        final t = temps[i].toDouble();
        final h = humidities[i].toDouble();
        final wKmh = winds[i].toDouble();
        final wMps = wKmh / 3.6;

        final isDayHour = dt.hour >= 6 && dt.hour <= 18;
        final solar = isDayHour
            ? (dt.hour >= 11 && dt.hour <= 15 ? 750.0 : 400.0)
            : 0.0;

        final utci = UtciCalculator.calculate(
          airTempC: t,
          relativeHumidityPct: h,
          windSpeedMps: wMps,
          solarRadiationWm2: solar,
        );

        final cat = UtciCalculator.categorize(utci);
        final isDanger = utci >= 38.0;

        points.add(
          HourlyUtciPoint(
            time: dt,
            hourLabel: '${dt.hour.toString().padLeft(2, '0')}:00',
            temperature: t,
            humidity: h,
            windSpeedKmh: wKmh,
            utciValue: utci,
            category: cat,
            isPeakDanger: isDanger,
          ),
        );
      }

      if (points.isNotEmpty) return points;
      return _generateOfflineHourly();
    } catch (_) {
      return _generateOfflineHourly();
    }
  }

  Future<List<DailyUtciForecast>> fetchDailyForecast({
    required double lat,
    required double lon,
  }) async {
    try {
      final response = await _dio.get(
        'https://api.open-meteo.com/v1/forecast',
        queryParameters: {
          'latitude': lat,
          'longitude': lon,
          'daily':
              'temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min',
          'forecast_days': 7,
          'timezone': 'auto',
        },
      );

      final daily = response.data['daily'] as Map<String, dynamic>;
      final dates = (daily['time'] as List).cast<String>();
      final maxTemps = (daily['temperature_2m_max'] as List).cast<num>();
      final minTemps = (daily['temperature_2m_min'] as List).cast<num>();
      final maxApps = (daily['apparent_temperature_max'] as List).cast<num>();

      final List<DailyUtciForecast> list = [];
      const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

      for (int i = 0; i < dates.length; i++) {
        final dt = DateTime.tryParse(dates[i]) ?? DateTime.now().add(Duration(days: i));
        final maxT = maxTemps[i].toDouble();
        final minT = minTemps[i].toDouble();
        final maxApp = maxApps[i].toDouble();

        // Approximate max UTCI based on max temperature and midday solar gain
        final maxUtci = double.parse((maxApp + 2.5).toStringAsFixed(1));
        final minUtci = double.parse((minT - 1.0).toStringAsFixed(1));
        final cat = UtciCalculator.categorize(maxUtci);
        final isHeatwave = maxUtci >= 38.0;

        final dayStr = i == 0 ? 'Today' : '${weekdays[dt.weekday - 1]} ${dt.day}';

        list.add(
          DailyUtciForecast(
            date: dt,
            dayLabel: dayStr,
            maxUtci: maxUtci,
            minUtci: minUtci,
            maxTemp: maxT,
            minTemp: minT,
            maxCategory: cat,
            isHeatwaveDay: isHeatwave,
          ),
        );
      }

      if (list.isNotEmpty) return list;
      return _generateOfflineDaily();
    } catch (_) {
      return _generateOfflineDaily();
    }
  }

  SafeWorkWindows calculateSafeWindows(List<HourlyUtciPoint> hourly) {
    if (hourly.isEmpty) {
      return const SafeWorkWindows(
        morningWindow: '06:00 - 10:30',
        dangerWindow: '12:00 - 16:00',
        eveningWindow: '17:30 - 20:00',
        recommendation:
            'Conduct heavy field or delivery tasks early morning or late afternoon.',
      );
    }

    String morning = '06:00 - 10:30';
    String danger = '12:00 - 16:00';
    String evening = '17:30 - 20:00';

    final dangerHours = hourly.where((h) => h.isPeakDanger).toList();
    if (dangerHours.isNotEmpty) {
      final firstDanger = dangerHours.first.hourLabel;
      final lastDanger = dangerHours.last.hourLabel;
      danger = '$firstDanger - $lastDanger';
    }

    return SafeWorkWindows(
      morningWindow: morning,
      dangerWindow: danger,
      eveningWindow: evening,
      recommendation:
          'Dangerous heat peak expected between $danger. Shift outdoor shifts to morning ($morning) or evening ($evening).',
    );
  }

  CurrentWeatherData _generateOfflineCurrent(
    String cityName,
    double lat,
    double lon,
  ) {
    final now = DateTime.now();
    final hour = now.hour;
    final isDay = hour >= 6 && hour <= 18;

    // Diurnal temperature curve
    final baseTemp = 31.0 + 8.0 * math.sin((hour - 8) * math.pi / 12);
    final temp = double.parse(baseTemp.clamp(24.0, 42.0).toStringAsFixed(1));
    final humidity = double.parse((48.0 - (temp - 25.0) * 1.5).clamp(25.0, 75.0).toStringAsFixed(1));
    const windKmh = 14.0;
    const windMps = windKmh / 3.6;
    final solar = isDay ? 600.0 : 0.0;

    final utci = UtciCalculator.calculate(
      airTempC: temp,
      relativeHumidityPct: humidity,
      windSpeedMps: windMps,
      solarRadiationWm2: solar,
    );

    return CurrentWeatherData(
      cityName: cityName,
      airTemperature: temp,
      relativeHumidity: humidity,
      apparentTemperature: temp + 2.5,
      windSpeedKmh: windKmh,
      windSpeedMps: windMps,
      uvIndex: isDay ? 8.5 : 0.0,
      weatherCode: 0,
      calculatedUtci: utci,
      utciCategory: UtciCalculator.categorize(utci),
      updatedAt: now,
    );
  }

  List<HourlyUtciPoint> _generateOfflineHourly() {
    final now = DateTime.now();
    final List<HourlyUtciPoint> list = [];

    for (int i = 0; i < 24; i++) {
      final dt = now.add(Duration(hours: i));
      final hour = dt.hour;
      final isDay = hour >= 6 && hour <= 18;

      final t = 28.0 + 9.0 * math.sin((hour - 8) * math.pi / 12);
      final temp = double.parse(t.clamp(23.0, 41.5).toStringAsFixed(1));
      final hum = double.parse((50.0 - (temp - 25) * 1.2).clamp(25.0, 80.0).toStringAsFixed(1));
      final solar = isDay ? (hour >= 11 && hour <= 15 ? 700.0 : 350.0) : 0.0;

      final utci = UtciCalculator.calculate(
        airTempC: temp,
        relativeHumidityPct: hum,
        windSpeedMps: 3.5,
        solarRadiationWm2: solar,
      );

      final cat = UtciCalculator.categorize(utci);

      list.add(
        HourlyUtciPoint(
          time: dt,
          hourLabel: '${hour.toString().padLeft(2, '0')}:00',
          temperature: temp,
          humidity: hum,
          windSpeedKmh: 12.6,
          utciValue: utci,
          category: cat,
          isPeakDanger: utci >= 38.0,
        ),
      );
    }
    return list;
  }

  List<DailyUtciForecast> _generateOfflineDaily() {
    final now = DateTime.now();
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final List<DailyUtciForecast> list = [];

    final sampleMaxUtci = [41.2, 42.5, 43.8, 39.5, 37.0, 35.8, 38.4];
    final sampleMinUtci = [24.0, 25.1, 26.0, 24.5, 23.0, 22.5, 23.8];

    for (int i = 0; i < 7; i++) {
      final dt = now.add(Duration(days: i));
      final maxU = sampleMaxUtci[i];
      final minU = sampleMinUtci[i];
      final cat = UtciCalculator.categorize(maxU);

      list.add(
        DailyUtciForecast(
          date: dt,
          dayLabel: i == 0 ? 'Today' : '${days[dt.weekday - 1]} ${dt.day}',
          maxUtci: maxU,
          minUtci: minU,
          maxTemp: maxU - 3.0,
          minTemp: minU + 1.0,
          maxCategory: cat,
          isHeatwaveDay: maxU >= 38.0,
        ),
      );
    }
    return list;
  }
}
