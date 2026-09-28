import 'package:hive/hive.dart';
import 'user_role.dart';

part 'app_user_model.g.dart';

@HiveType(typeId: 0)
class AppUserModel extends HiveObject {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String? photoUrl;
  @HiveField(4)
  final String roleKey; // stores UserRole.backendKey — enums aren't Hive-native

  AppUserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.roleKey,
    this.photoUrl,
  });

  UserRole get role => UserRole.fromBackendKey(roleKey);
}
