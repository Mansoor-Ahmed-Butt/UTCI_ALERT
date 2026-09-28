import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  AppConstants._();

  static String get backendBaseUrl =>
      dotenv.env['BACKEND_BASE_URL'] ?? 'https://your-backend.example.com';

  static const String userBoxName = 'user_box';
  static const String statusBoxName = 'status_box';
  static const String settingsBoxName = 'settings_box';
}
