import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Neutral surfaces
  static const Color surfaceLight = Color(0xFFF9F9FB);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF101216);
  static const Color cardDark = Color(0xFF191D24);

  static const Color onSurfaceLight = Color(0xFF1B1D21);
  static const Color onSurfaceDark = Color(0xFFEFF1F5);

  // Brand Accent (Warm Amber / Solar Gold)
  static const Color accent = Color(0xFFEAA239);
  static const Color accentMuted = Color(0xFFFFF2DC);
  static const Color accentDarkMuted = Color(0xFF2C2418);

  // Border & Divider
  static const Color dividerLight = Color(0xFFE6E8EC);
  static const Color dividerDark = Color(0xFF262C36);
  static const Color darkMode = Color(0xFF14171E);

  // UTCI Category Colors (based on bioclimatic heat stress scale)
  // < 9°C: Cold stress
  static const Color coldStress = Color(0xFF4A90E2);
  // 9°C - 26°C: No thermal stress (Comfort)
  static const Color noStress = Color(0xFF2EB872);
  // 26°C - 32°C: Moderate heat stress
  static const Color moderateStress = Color(0xFFF39C12);
  // 32°C - 38°C: Strong heat stress
  static const Color strongStress = Color(0xFFE67E22);
  // 38°C - 46°C: Very strong heat stress
  static const Color veryStrongStress = Color(0xFFE74C3C);
  // >= 46°C: Extreme heat stress
  static const Color extremeStress = Color(0xFF8E1B1B);

  static Color statusColor(String category) {
    switch (category.toLowerCase()) {
      case 'cold_stress':
        return coldStress;
      case 'no_stress':
        return noStress;
      case 'moderate':
        return moderateStress;
      case 'strong':
        return strongStress;
      case 'very_strong':
        return veryStrongStress;
      case 'extreme':
        return extremeStress;
      default:
        return accent;
    }
  }

  static LinearGradient gaugeGradient = const LinearGradient(
    colors: [
      coldStress,
      noStress,
      moderateStress,
      strongStress,
      veryStrongStress,
      extremeStress,
    ],
    stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
  );

  static LinearGradient statusGradient(String category) {
    final base = statusColor(category);
    return LinearGradient(
      colors: [base.withValues(alpha: 0.85), base],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}
