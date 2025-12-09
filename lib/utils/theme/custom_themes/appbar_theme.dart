import 'package:flutter/material.dart';

/// A class that provides custom [AppBar] themes for the application.
///
/// This class contains static constants for both light and dark [AppBar] themes.
/// It is designed with a private constructor to prevent instantiation.
class MagicAppBarTheme {
  MagicAppBarTheme._();

  /// The [AppBar] theme for the light mode.
  ///
  /// This theme features a transparent background, no elevation, and black icons and text.
  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.black, size: 24),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  /// The [AppBar] theme for the dark mode.
  ///
  /// This theme features a transparent background, no elevation, and white icons and text.
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );
}
