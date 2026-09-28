import 'package:get/get.dart';
import '../controllers/ai_advisor_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/forecast_controller.dart';
import '../controllers/guidance_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/main_nav_controller.dart';
import '../controllers/settings_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainNavController());

    Get.lazyPut(
      () => DashboardController(
        statusRepository: Get.find(),
        authRepository: Get.find(),
        notificationService: Get.find(),
        locationService: Get.find(),
        weatherRemote: Get.find(),
        aiAdvisor: Get.find(),
        tts: Get.find(),
      ),
    );

    Get.lazyPut(
      () => ForecastController(
        weatherRemote: Get.find(),
        tts: Get.find(),
      ),
    );

    Get.lazyPut(
      () => AiAdvisorController(
        aiAdvisor: Get.find(),
        tts: Get.find(),
      ),
    );

    Get.lazyPut(
      () => GuidanceController(
        tts: Get.find(),
      ),
    );

    Get.lazyPut(
      () => SettingsController(
        tts: Get.find(),
      ),
    );

    Get.lazyPut(
      () => HomeController(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
  }
}
