import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

/// A rounded container widget with customizable properties.
class MagicRoundedContainer extends StatelessWidget {
  /// Creates a rounded container.
  const MagicRoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.showBorder = false,
    this.radius = MagicSizes.cardRadiusLg,
    this.backgroundColor = MagicColors.white,
    this.borderColor = MagicColors.borderPrimary,
  });

  /// The width of the container.
  final double? width;

  /// The height of the container.
  final double? height;

  /// The border radius of the container.
  final double radius;

  /// The child widget to display inside the container.
  final Widget? child;

  /// Whether to show a border around the container.
  final bool showBorder;

  /// The color of the border.
  final Color borderColor;

  /// The background color of the container.
  final Color backgroundColor;

  /// The padding of the container.
  final EdgeInsetsGeometry? padding;

  /// The margin of the container.
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
