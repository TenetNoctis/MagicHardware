import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

/// A circular container widget with customizable properties.
class MagicCircularContainer extends StatelessWidget {
  /// Creates a [MagicCircularContainer].
  ///
  /// - [child]: The widget to display inside the container.
  /// - [width]: The width of the container.
  /// - [height]: The height of the container.
  /// - [radius]: The border radius of the container.
  /// - [padding]: The padding inside the container.
  /// - [backgroundColor]: The background color of the container.
  /// - [margin]: The margin around the container.
  const MagicCircularContainer({
    super.key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0,
    this.backgroundColor = MagicColors.white,
    this.margin,
  });

  /// The width of the container.
  final double? width;

  /// The height of the container.
  final double? height;

  /// The border radius of the container.
  final double radius;

  /// The padding inside the container.
  final double padding;

  /// The margin around the container.
  final EdgeInsets? margin;

  /// The widget to display inside the container.
  final Widget? child;

  /// The background color of the container.
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
