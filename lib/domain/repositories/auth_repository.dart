import '../../core/utils/result.dart';
import '../../data/models/app_user_model.dart';
import '../../data/models/user_role.dart';

abstract class AuthRepository {
  /// Signs in with Google, persists the user + role to Hive, and
  /// returns the cached-shape AppUserModel. Never throws — failures
  /// come back through Result.
  Future<Result<AppUserModel>> signInWithGoogle({required UserRole role});

  /// Saves a user model directly to local storage (e.g. for guest / demo mode)
  Future<void> saveUser(AppUserModel user);

  /// Returns a Hive-cached user immediately, if one exists — used for
  /// the cold-start "already signed in" fast path.
  AppUserModel? get cachedUser;

  Future<void> signOut();
}
