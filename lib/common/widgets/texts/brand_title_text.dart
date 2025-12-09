import 'package:flutter/material.dart';

import '../../../utils/constants/enums.dart';

/// A text widget for displaying brand titles with customizable styling.
class MagicBrandTitleText extends StatelessWidget {
  /// Creates a [MagicBrandTitleText] widget.
  const MagicBrandTitleText({
    super.key,
    this.color,
    this.maxLines = 1,
    required this.title,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  /// The color of the text.
  final Color? color;

  /// The brand title to display.
  final String title;

  /// The maximum number of lines for the text.
  final int maxLines;

  /// The alignment of the text.
  final TextAlign? textAlign;

  /// The size of the brand text, as defined by [TextSizes].
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      // Check which brandSize is required and set that style.
      style: brandTextSize == TextSizes.small
          ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
          : brandTextSize == TextSizes.medium
          ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
          : brandTextSize == TextSizes.large
          ? Theme.of(context).textTheme.titleLarge!.apply(color: color)
          : Theme.of(context).textTheme.bodyMedium!.apply(color: color),
    );
  }
}
