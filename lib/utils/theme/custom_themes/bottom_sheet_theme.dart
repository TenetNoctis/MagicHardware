import 'package:flutter/material.dart';

/// A class that provides custom [BottomSheet] themes for the application.
///
/// This class contains static constants for both light and dark [BottomSheet] themes.
/// It is designed with a private constructor to prevent instantiation.
class MagicBottomSheetTheme {
  MagicBottomSheetTheme._();

  /// The [BottomSheet] theme for the light mode.
  ///
  /// This theme features a white background, rounded corners, and a drag handle.
  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.white,
    modalBackgroundColor: Colors.white,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
  );

  /// The [BottomSheet] theme for the dark mode.
  ///
  /// This theme features a black background, rounded corners, and a drag handle.
  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.black,
    modalBackgroundColor: Colors.black,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
  );
}
