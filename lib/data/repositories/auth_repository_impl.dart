import '../../core/errors/failure.dart';
import '../../core/utils/result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/google_auth_datasource.dart';
import '../datasources/hive_local_datasource.dart';
import '../models/app_user_model.dart';
import '../models/user_role.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GoogleAuthDataSource _googleAuth;
  final HiveLocalDataSource _local;

  AuthRepositoryImpl(this._googleAuth, this._local);

  @override
  Future<Result<AppUserModel>> signInWithGoogle({required UserRole role}) async {
    try {
      final firebaseUser = await _googleAuth.signIn();
      if (firebaseUser == null) {
        return Result.failure(const Failure('Sign-in was cancelled.'));
      }

      final user = AppUserModel(
        uid: firebaseUser.uid,
        name: firebaseUser.displayName ?? 'Unknown',
        email: firebaseUser.email ?? '',
        photoUrl: firebaseUser.photoURL,
        roleKey: role.backendKey,
      );

      await _local.saveUser(user);
      return Result.success(user);
    } catch (e) {
      return Result.failure(Failure.auth(e));
    }
  }

  @override
  Future<void> saveUser(AppUserModel user) => _local.saveUser(user);

  @override
  AppUserModel? get cachedUser => _local.cachedUser;

  @override
  Future<void> signOut() async {
    await _googleAuth.signOut();
    await _local.clearUser();
  }
}
