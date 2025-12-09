import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

/// A widget that displays a shimmering effect, used as a placeholder while loading data.
class MagicShimmerEffect extends StatelessWidget {
  /// Creates a [MagicShimmerEffect] widget.
  const MagicShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius = 5,
    this.color,
  });

  /// The width of the shimmer effect.
  final double width;

  /// The height of the shimmer effect.
  final double height;

  /// The border radius of the shimmer effect.
  final double radius;

  /// The color of the container. If not provided, it will be determined by the theme.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (dark ? MagicColors.darkerGrey : MagicColors.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
