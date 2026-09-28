import 'package:get/get.dart';
import '../../data/models/user_role.dart';
import '../../services/tts_service.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/theme_controller.dart';

class SettingsController extends GetxController {
  final TtsService _tts;
  final ThemeController _themeController = Get.find<ThemeController>();

  SettingsController({required TtsService tts}) : _tts = tts;

  DashboardController get _dashboard => Get.find<DashboardController>();

  final RxDouble alertThreshold = 32.0.obs; // UTCI °C threshold to trigger alerts
  final RxBool autoVoiceEnabled = true.obs;

  double get speechRate => _tts.speechRate.value;
  double get pitch => _tts.pitch.value;
  bool get isDarkMode => _themeController.isDark;

  void setRole(UserRole role) {
    _dashboard.selectRole(role);
  }

  void setThreshold(double val) {
    alertThreshold.value = val;
  }

  void setSpeechRate(double val) {
    _tts.setRate(val);
  }

  void setPitch(double val) {
    _tts.setPitch(val);
  }

  void toggleTheme() {
    _themeController.toggle();
  }

  Future<void> testVoice() async {
    await _tts.testVoice();
  }
}
