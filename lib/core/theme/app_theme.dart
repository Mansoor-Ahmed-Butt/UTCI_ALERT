import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.surfaceLight,
        colorScheme: const ColorScheme.light(
          surface: AppColors.cardLight,
          onSurface: AppColors.onSurfaceLight,
          primary: AppColors.accent,
          onPrimary: Colors.black87,
          secondary: Color(0xFFE67E22),
          error: Color(0xFFD93829),
        ),
        dividerColor: AppColors.dividerLight,
        textTheme: AppTextStyles.textTheme(AppColors.onSurfaceLight),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surfaceLight,
          foregroundColor: AppColors.onSurfaceLight,
          elevation: 0,
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
        ),
        cardTheme: CardThemeData(
          color: AppColors.cardLight,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.dividerLight, width: 1),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: Colors.black87,
            disabledBackgroundColor: AppColors.accentMuted,
            disabledForegroundColor: Colors.black38,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.cardLight,
          elevation: 4,
          indicatorColor: AppColors.accentMuted,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF9E6500),
              );
            }
            return const TextStyle(fontSize: 12, color: Colors.black54);
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: Color(0xFF9E6500), size: 24);
            }
            return const IconThemeData(color: Colors.black54, size: 22);
          }),
        ),
      );

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.surfaceDark,
        colorScheme: const ColorScheme.dark(
          surface: AppColors.cardDark,
          onSurface: AppColors.onSurfaceDark,
          primary: AppColors.accent,
          onPrimary: Colors.black87,
          secondary: Color(0xFFE67E22),
          error: Color(0xFFE74C3C),
        ),
        dividerColor: AppColors.dividerDark,
        textTheme: AppTextStyles.textTheme(AppColors.onSurfaceDark),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surfaceDark,
          foregroundColor: AppColors.onSurfaceDark,
          elevation: 0,
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
        ),
        cardTheme: CardThemeData(
          color: AppColors.cardDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.dividerDark, width: 1),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: Colors.black87,
            disabledBackgroundColor: AppColors.dividerDark,
            disabledForegroundColor: Colors.white24,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: AppColors.cardDark,
          elevation: 4,
          indicatorColor: AppColors.accentDarkMuted,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.accent,
              );
            }
            return const TextStyle(fontSize: 12, color: Colors.white60);
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: AppColors.accent, size: 24);
            }
            return const IconThemeData(color: Colors.white60, size: 22);
          }),
        ),
      );
}
