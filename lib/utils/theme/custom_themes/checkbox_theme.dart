import 'package:flutter/material.dart';

/// A class that provides custom [Checkbox] themes for the application.
///
/// This class contains static constants for both light and dark [Checkbox] themes.
/// It is designed with a private constructor to prevent instantiation.
class MagicCheckboxTheme {
  MagicCheckboxTheme._();

  /// The [Checkbox] theme for the light mode.
  ///
  /// This theme features a rounded square shape and a blue fill color when selected.
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.blue;
      } else {
        return Colors.transparent;
      }
    }),
  );

  /// The [Checkbox] theme for the dark mode.
  ///
  /// This theme features a rounded square and a blue fill color when selected.
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.blue;
      } else {
        return Colors.transparent;
      }
    }),
  );
}
