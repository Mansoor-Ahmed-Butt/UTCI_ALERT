import 'package:flutter/material.dart';

/// Extension methods on [BuildContext] for clean, centralized access
/// to theme, brightness, color scheme, and responsive metrics.
extension ContextExtensions on BuildContext {
  /// Returns `true` if the current active theme brightness is dark.
  ///
  /// Subscribes the widget to [Theme.of], so the widget automatically
  /// rebuilds when the app switches between light and dark themes.
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  /// Quick accessor for the current [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// Quick accessor for the active [ColorScheme].
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Quick accessor for the active [TextTheme].
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Quick accessor for screen [Size].
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Quick accessor for screen width.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Quick accessor for screen height.
  double get screenHeight => MediaQuery.sizeOf(this).height;
}
