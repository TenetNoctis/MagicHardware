import 'package:flutter/material.dart';
import 'package:magic_hardware/utils/constants/colors.dart';

/// A class that provides custom [OutlinedButton] themes for the application.
///
/// This class contains static constants for both light and dark `OutlinedButton` themes.
/// It is designed with a private constructor to prevent instantiation.
class MagicOutlinedButtonTheme {
  MagicOutlinedButtonTheme._();

  /// The [OutlinedButton] theme for the light mode.
  ///
  /// This theme features black text, a primary-colored border, and rounded corners.
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      side: const BorderSide(color: MagicColors.primary),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );

  /// The [OutlinedButton] theme for the dark mode.
  ///
  /// This theme features white text, a primary-colored border, and rounded corners.
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      side: const BorderSide(color: MagicColors.primary),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}
