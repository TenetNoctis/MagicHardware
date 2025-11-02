import 'package:flutter/material.dart';
import 'custom_themes/appbar_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outlined_button_theme.dart';

class MagicAppTheme {
  MagicAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
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

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
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