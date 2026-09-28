import '../../core/utils/utci_calculator.dart';

class CurrentWeatherData {
  final String cityName;
  final double airTemperature;
  final double relativeHumidity;
  final double apparentTemperature;
  final double windSpeedKmh;
  final double windSpeedMps;
  final double uvIndex;
  final int weatherCode;
  final double calculatedUtci;
  final String utciCategory;
  final DateTime updatedAt;

  const CurrentWeatherData({
    required this.cityName,
    required this.airTemperature,
    required this.relativeHumidity,
    required this.apparentTemperature,
    required this.windSpeedKmh,
    required this.windSpeedMps,
    required this.uvIndex,
    required this.weatherCode,
    required this.calculatedUtci,
    required this.utciCategory,
    required this.updatedAt,
  });

  String get categoryLabel => UtciCalculator.getCategoryLabel(utciCategory);

  String get weatherDescription {
    switch (weatherCode) {
      case 0:
        return 'Clear Sky';
      case 1:
      case 2:
        return 'Partly Cloudy';
      case 3:
        return 'Overcast';
      case 45:
      case 48:
        return 'Haze / Dust';
      case 51:
      case 53:
      case 55:
        return 'Light Drizzle';
      case 61:
      case 63:
      case 65:
        return 'Rain Shower';
      case 80:
      case 81:
      case 82:
        return 'Heavy Rain';
      case 95:
      case 96:
      case 99:
        return 'Thunderstorm';
      default:
        return 'Sunny / Clear';
    }
  }
}

class HourlyUtciPoint {
  final DateTime time;
  final String hourLabel;
  final double temperature;
  final double humidity;
  final double windSpeedKmh;
  final double utciValue;
  final String category;
  final bool isPeakDanger;

  const HourlyUtciPoint({
    required this.time,
    required this.hourLabel,
    required this.temperature,
    required this.humidity,
    required this.windSpeedKmh,
    required this.utciValue,
    required this.category,
    required this.isPeakDanger,
  });
}

class DailyUtciForecast {
  final DateTime date;
  final String dayLabel;
  final double maxUtci;
  final double minUtci;
  final double maxTemp;
  final double minTemp;
  final String maxCategory;
  final bool isHeatwaveDay;

  const DailyUtciForecast({
    required this.date,
    required this.dayLabel,
    required this.maxUtci,
    required this.minUtci,
    required this.maxTemp,
    required this.minTemp,
    required this.maxCategory,
    required this.isHeatwaveDay,
  });
}

class SafeWorkWindows {
  final String morningWindow;
  final String dangerWindow;
  final String eveningWindow;
  final String recommendation;

  const SafeWorkWindows({
    required this.morningWindow,
    required this.dangerWindow,
    required this.eveningWindow,
    required this.recommendation,
  });
}
