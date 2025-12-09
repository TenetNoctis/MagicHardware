import 'package:flutter/material.dart';

/// A text widget for displaying product titles with customizable styling.
class MagicProductTitleText extends StatelessWidget {
  /// Creates a [MagicProductTitleText] widget.
  const MagicProductTitleText({
    super.key,
    required this.title,
    this.smallSize = false,
    this.maxLines = 2,
    this.textAlign = TextAlign.left,
  });

  /// The title of the product.
  final String title;

  /// Whether to use a smaller font size for the title.
  final bool smallSize;

  /// The maximum number of lines for the title.
  final int maxLines;

  /// The alignment of the text.
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: smallSize
          ? Theme.of(context).textTheme.labelLarge
          : Theme.of(context).textTheme.titleSmall,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
