import 'package:flutter/material.dart';

/// Convenience extension for accessing theme tokens.
extension FirstRunThemeContext on BuildContext {
  /// Shortcut to the current [ColorScheme].
  ColorScheme get firstRunColors => Theme.of(this).colorScheme;

  /// Shortcut to the current [TextTheme].
  TextTheme get firstRunTextTheme => Theme.of(this).textTheme;
}
