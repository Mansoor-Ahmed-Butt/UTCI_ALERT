import 'package:get/get.dart';
import '../../data/models/app_user_model.dart';
import '../../data/models/user_role.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/register_device_usecase.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';
import '../../services/location_service.dart';
import '../../services/notification_service.dart';
import '../../routes/app_routes.dart';

class AuthController extends GetxController {
  final SignInWithGoogleUseCase _signIn;
  final RegisterDeviceUseCase _registerDevice;
  final LocationService _locationService;
  final NotificationService _notificationService;
  final AuthRepository _authRepository;

  AuthController(
    this._signIn,
    this._registerDevice,
    this._locationService,
    this._notificationService,
    this._authRepository,
  );

  final Rx<UserRole?> selectedRole = Rx<UserRole?>(UserRole.outdoorWorker);
  final RxBool isSigningIn = false.obs;
  final RxnString errorMessage = RxnString();

  @override
  void onInit() {
    super.onInit();
    // Fast path: skip straight to Home without flashing the sign-in
    // screen when either (a) Hive already has a cached user (a
    // returning user), or (b) the app was cold-launched by tapping a
    // notification while fully terminated (flagged by main.dart).
    if (_authRepository.cachedUser != null || NotificationService.hadTerminatedLaunchAlert) {
      Future.microtask(() => Get.offAllNamed(AppRoutes.home));
    }
  }

  void selectRole(UserRole role) => selectedRole.value = role;

  Future<void> continueAsGuest() async {
    final role = selectedRole.value ?? UserRole.outdoorWorker;
    final guestUser = AppUserModel(
      uid: 'guest_${DateTime.now().millisecondsSinceEpoch}',
      name: '${role.label} Member',
      email: 'community@utcialert.org',
      roleKey: role.backendKey,
    );
    await _authRepository.saveUser(guestUser);
    Get.offAllNamed(AppRoutes.home);
  }

  Future<void> signInWithGoogle() async {
    if (selectedRole.value == null) return;
    isSigningIn.value = true;
    errorMessage.value = null;

    final result = await _signIn(role: selectedRole.value!);

    await result.when(
      success: (user) async {
        await _notificationService.requestPermission();
        final position = await _locationService.getCurrentPosition();
        final fcmToken = await _notificationService.getToken();

        if (fcmToken != null && position != null) {
          await _registerDevice(
            fcmToken: fcmToken,
            city: position.city,
            lat: position.latitude,
            lon: position.longitude,
            profile: selectedRole.value!.backendKey,
          );
        }
        Get.offAllNamed(AppRoutes.home);
      },
      failure: (failure) async {
        errorMessage.value = failure.message;
      },
    );

    isSigningIn.value = false;
  }
}
