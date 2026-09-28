import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  AppConstants._();

  static String get backendBaseUrl {
    try {
      if (dotenv.isInitialized) {
        return dotenv.env['BACKEND_BASE_URL'] ?? 'https://your-backend.example.com';
      }
    } catch (_) {}
    return 'https://your-backend.example.com';
  }

  static String get geminiApiKey {
    try {
      if (dotenv.isInitialized) {
        return dotenv.env['GEMINI_API_KEY'] ?? '';
      }
    } catch (_) {}
    return '';
  }

  static const String userBoxName = 'user_box';
  static const String statusBoxName = 'status_box';
  static const String settingsBoxName = 'settings_box';
}
