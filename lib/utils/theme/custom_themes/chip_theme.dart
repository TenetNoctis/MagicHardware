import 'package:flutter/material.dart';
import 'package:magic_hardware/utils/constants/colors.dart';

/// A class that provides custom [Chip] themes for the application.
///
/// This class contains static constants for both light and dark [Chip] themes.
/// It is designed with a private constructor to prevent instantiation.
class MagicChipTheme {
  MagicChipTheme._();

  /// The [Chip] theme for the light mode.
  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey..withValues(alpha: 0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: MagicColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: MagicColors.white,
  );

  /// The [Chip] theme for the dark mode.
  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: MagicColors.darkerGrey,
    labelStyle: TextStyle(color: MagicColors.white),
    selectedColor: MagicColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: Colors.white,
  );
}
