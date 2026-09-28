import 'package:hive_flutter/hive_flutter.dart';
import '../models/app_user_model.dart';
import '../models/utci_status_model.dart';
import '../../core/constants/app_constants.dart';

/// Single place that opens/reads/writes Hive boxes. Nothing else in
/// the app calls Hive.box(...) directly — that avoids the same box
/// name being typo'd in three different files.
class HiveLocalDataSource {
  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(AppUserModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UtciStatusModelAdapter());
    }
    await Hive.openBox<AppUserModel>(AppConstants.userBoxName);
    await Hive.openBox<UtciStatusModel>(AppConstants.statusBoxName);
    await Hive.openBox(AppConstants.settingsBoxName); // theme + misc settings
  }

  Box<AppUserModel> get _userBox => Hive.box(AppConstants.userBoxName);
  Box<UtciStatusModel> get _statusBox => Hive.box(AppConstants.statusBoxName);

  Future<void> saveUser(AppUserModel user) => _userBox.put('current', user);
  AppUserModel? get cachedUser => _userBox.get('current');
  Future<void> clearUser() => _userBox.delete('current');

  Future<void> saveStatus(UtciStatusModel status) => _statusBox.put('latest', status);
  UtciStatusModel? get cachedStatus => _statusBox.get('latest');
}
