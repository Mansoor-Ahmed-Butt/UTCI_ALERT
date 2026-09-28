import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/app_constants.dart';

class ThemeController extends GetxController {
  final Box _settingsBox = Hive.box(AppConstants.settingsBoxName);

  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  bool get isDark => themeMode.value == ThemeMode.dark;

  @override
  void onInit() {
    super.onInit();
    final saved = _settingsBox.get('themeMode', defaultValue: 'system') as String;
    themeMode.value = _fromString(saved);
  }

  void toggle() {
    final next = themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    themeMode.value = next;
    _settingsBox.put('themeMode', next.name);
    Get.changeThemeMode(next);
  }

  ThemeMode _fromString(String v) => switch (v) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
}
