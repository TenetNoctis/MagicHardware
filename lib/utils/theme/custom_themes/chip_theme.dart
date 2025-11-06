import 'package:flutter/material.dart';
import 'package:magic_hardware/utils/constants/colors.dart';

class MagicChipTheme {
  MagicChipTheme ._ ();

  // Light Theme
  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey..withValues(alpha: 0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: MagicColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: MagicColors.white,
  );

  // Dark Theme
  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: MagicColors.darkerGrey,
    labelStyle: TextStyle(color: MagicColors.white),
    selectedColor: MagicColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: Colors.white,
  );
}