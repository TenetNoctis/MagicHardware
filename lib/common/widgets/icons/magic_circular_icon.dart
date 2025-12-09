import 'package:flutter/material.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

/// A circular icon widget with a background color and an optional onPressed callback.
class MagicCircularIcon extends StatelessWidget {
  /// Creates a circular icon.
  const MagicCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = MagicSizes.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });

  /// The width of the container.
  final double? width;

  /// The height of the container.
  final double? height;

  /// The size of the icon.
  final double? size;

  /// The icon to display.
  final IconData icon;

  /// The color of the icon.
  final Color? color;

  /// The background color of the icon.
  final Color? backgroundColor;

  /// The callback function when the icon is pressed.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor != null
            ? backgroundColor!
            : dark
            ? MagicColors.darkerGrey.withValues(alpha: 0.5)
            : MagicColors.white.withValues(alpha: 0.9),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: size),
      ),
    );
  }
}
