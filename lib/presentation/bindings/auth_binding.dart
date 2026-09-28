import 'package:get/get.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/status_repository.dart';
import '../../domain/usecases/register_device_usecase.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';
import '../../services/location_service.dart';
import '../../services/notification_service.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInWithGoogleUseCase(Get.find<AuthRepository>()));
    Get.lazyPut(() => RegisterDeviceUseCase(Get.find<StatusRepository>()));
    Get.lazyPut(
      () => AuthController(
        Get.find<SignInWithGoogleUseCase>(),
        Get.find<RegisterDeviceUseCase>(),
        Get.find<LocationService>(),
        Get.find<NotificationService>(),
        Get.find<AuthRepository>(),
      ),
    );
  }
}
