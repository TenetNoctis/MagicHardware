import 'package:flutter/material.dart';
import 'package:magic_hardware/utils/constants/colors.dart';

/// A class that defines custom shadow styles for the application.
class MagicShadowStyle {
  /// A vertical shadow style for product images.
  static final verticalProductShadow = BoxShadow(
    color: MagicColors.darkGrey.withValues(alpha: 0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );

  /// A horizontal shadow style for product images.
  static final horizontalProductShadow = BoxShadow(
    color: MagicColors.darkGrey.withValues(alpha: 0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );
}
