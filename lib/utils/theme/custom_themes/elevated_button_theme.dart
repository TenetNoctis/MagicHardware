import 'package:flutter/material.dart';
import 'package:magic_hardware/utils/constants/colors.dart';

/// A class that provides custom [ElevatedButton] themes for the application.
///
/// This class contains static constants for both light and dark `ElevatedButton` themes.
/// It is designed with a private constructor to prevent instantiation.
class MagicElevatedButtonTheme {
  MagicElevatedButtonTheme._();

  /// The [ElevatedButton] theme for the light mode.
  ///
  /// This theme features a primary background color, white text, and rounded corners.
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: MagicColors.primary,
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
      side: const BorderSide(color: MagicColors.primary),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  /// The [ElevatedButton] theme for the dark mode.
  ///
  /// This theme also features a primary background color, white text, and rounded corners,
  /// ensuring consistency across both light and dark themes.
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: MagicColors.primary,
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
      side: const BorderSide(color: MagicColors.primary),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
