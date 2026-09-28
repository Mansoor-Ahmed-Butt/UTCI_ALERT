import '../../core/utils/result.dart';
import '../repositories/status_repository.dart';

class RegisterDeviceUseCase {
  final StatusRepository _repository;
  RegisterDeviceUseCase(this._repository);

  Future<Result<bool>> call({
    required String fcmToken,
    required String city,
    required double lat,
    required double lon,
    required String profile,
  }) =>
      _repository.registerDevice(
        fcmToken: fcmToken,
        city: city,
        lat: lat,
        lon: lon,
        profile: profile,
      );
}
