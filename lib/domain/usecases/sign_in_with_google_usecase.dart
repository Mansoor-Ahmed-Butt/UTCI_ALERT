import '../../core/utils/result.dart';
import '../../data/models/app_user_model.dart';
import '../../data/models/user_role.dart';
import '../repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository _repository;
  SignInWithGoogleUseCase(this._repository);

  Future<Result<AppUserModel>> call({required UserRole role}) =>
      _repository.signInWithGoogle(role: role);
}
