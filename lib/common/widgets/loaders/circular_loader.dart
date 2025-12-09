import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

/// A circular loader widget with customizable foreground and background colors.
class MagicCircularLoader extends StatelessWidget {
  /// Creates a circular loader.
  const MagicCircularLoader({
    super.key,
    this.foregroundColor = MagicColors.white,
    this.backgroundColor = MagicColors.primary,
  });

  /// The color of the circular progress indicator.
  final Color? foregroundColor;

  /// The background color of the loader.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(MagicSizes.lg),
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Center(
        child: CircularProgressIndicator(
          color: foregroundColor,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
