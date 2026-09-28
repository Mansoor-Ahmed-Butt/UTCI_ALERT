import 'package:get/get.dart';
import '../../data/models/app_user_model.dart';
import '../../data/models/utci_status_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/status_repository.dart';
import '../../services/location_service.dart';
import '../../services/notification_service.dart';
import '../../routes/app_routes.dart';

class HomeController extends GetxController {
  final StatusRepository _statusRepository;
  final AuthRepository _authRepository;
  final NotificationService _notificationService;
  final LocationService _locationService;

  HomeController(
    this._statusRepository,
    this._authRepository,
    this._notificationService,
    this._locationService,
  );

  final Rxn<UtciStatusModel> status = Rxn<UtciStatusModel>();
  final Rxn<String> latestAlertSuggestion = Rxn<String>();
  final RxBool isRefreshing = false.obs;

  AppUserModel? get user => _authRepository.cachedUser;

  @override
  void onInit() {
    super.onInit();
    // Offline-first: show whatever is cached immediately, so the
    // dashboard never shows a blank/loading state on a cold, offline
    // start.
    status.value = _statusRepository.cachedStatus;

    _notificationService.listen(onAlert: _onAlert);
    refresh();
  }

  @override
  Future<void> refresh() async {
    // Prefer the city already tied to the cached reading; only ask
    // for a fresh location fix when there's nothing cached yet (e.g.
    // first cold start after sign-in).
    String? city = status.value?.city;
    if (city == null) {
      final position = await _locationService.getCurrentPosition();
      city = position?.city;
    }
    if (city == null) return; // no cached city and no location fix — stay offline

    isRefreshing.value = true;
    final result = await _statusRepository.refreshStatus(city: city);
    result.when(
      success: (fresh) {
        status.value = fresh;
      },
      failure: (_) {}, // stay on cached value — offline-first, no error banner needed
    );
    isRefreshing.value = false;
  }

  void _onAlert(String category, String? suggestion) {
    latestAlertSuggestion.value = suggestion;
    if (status.value != null) {
      status.value = UtciStatusModel(
        category: category,
        value: status.value!.value,
        city: status.value!.city,
        updatedAt: DateTime.now(),
        suggestion: suggestion,
      );
      _statusRepository.cacheStatus(status.value!);
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    Get.offAllNamed(AppRoutes.auth);
  }
}
