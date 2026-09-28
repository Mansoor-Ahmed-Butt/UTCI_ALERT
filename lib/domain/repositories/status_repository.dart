import '../../core/utils/result.dart';
import '../../data/models/utci_status_model.dart';

abstract class StatusRepository {
  /// Registers this device's FCM token + location + role with the backend.
  /// Resolves to Result.success(true) on success.
  Future<Result<bool>> registerDevice({
    required String fcmToken,
    required String city,
    required double lat,
    required double lon,
    required String profile,
  });

  /// Offline-first read: returns the Hive-cached status immediately,
  /// then (if connected) refreshes from the backend.
  UtciStatusModel? get cachedStatus;

  Future<Result<UtciStatusModel>> refreshStatus({required String city});

  Future<void> cacheStatus(UtciStatusModel status);
}
