import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

/// Light/dark toggle, drops into any screen's app bar.
class ThemeToggleSwitch extends StatelessWidget {
  const ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ThemeController>();
    return Obx(() {
      final isDark = controller.themeMode.value == ThemeMode.dark;
      return IconButton(
        icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
        tooltip: 'Toggle theme',
        onPressed: controller.toggle,
      );
    });
  }
}
