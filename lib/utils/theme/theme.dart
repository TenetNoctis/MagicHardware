import 'package:flutter/material.dart';
import 'package:magic_hardware/utils/constants/colors.dart';

import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outlined_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';

/// A class that holds the theme data for the Magic Hardware app.
class MagicAppTheme {
  /// A class that holds the theme data for the Magic Hardware app.
  MagicAppTheme._();

  /// The light theme for the app.
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: MagicColors.primary,
    textTheme: MagicTextTheme.lightTextTheme,
    chipTheme: MagicChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: MagicAppBarTheme.lightAppBarTheme,
    checkboxTheme: MagicCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: MagicBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: MagicElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: MagicOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: MagicTextFormFieldTheme.lightInputDecorationTheme,
  );

  /// The dark theme for the app.
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: MagicColors.primary,
    textTheme: MagicTextTheme.darkTextTheme,
    chipTheme: MagicChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: MagicAppBarTheme.darkAppBarTheme,
    checkboxTheme: MagicCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: MagicBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: MagicElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: MagicOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: MagicTextFormFieldTheme.darkInputDecorationTheme,
  );
}
