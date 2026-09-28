import 'package:flutter/material.dart';

/// Responsive layout helper ensuring clean UI on mobile screens,
/// iPads/tablets, and desktop/web 
class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 650 &&
      MediaQuery.sizeOf(context).width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1024;

  static double contentWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width > 1200) return 1100;
    if (width > 800) return width * 0.92;
    return width;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1024 && desktop != null) {
      return desktop!;
    }
    if (width >= 650 && tablet != null) {
      return tablet!;
    }
    return mobile;
  }
}
