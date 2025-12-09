import 'package:flutter/material.dart';

/// A widget to display product prices with customizable currency and styling.
class MagicProductPriceText extends StatelessWidget {
  /// Creates a [MagicProductPriceText] widget.
  const MagicProductPriceText({
    super.key,
    this.currencySign = 'MVR ',
    required this.price,
    this.isLarge = false,
    this.maxLines = 1,
    this.lineThrough = false,
  });

  /// The currency symbol to display.
  final String currencySign;

  /// The price of the product, as a string. Can be a single value or a range (e.g., "100.00 - 250.00").
  final String price;

  /// The maximum number of lines for the text.
  final int maxLines;

  /// Whether to display the price in a large font size.
  final bool isLarge;

  /// Whether to apply a line-through decoration to the text.
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    // Check if the price string contains a hyphen, indicating a range.
    final isPriceRange = price.contains('-');

    // If it's a range, use the string as is. Otherwise, parse and format it.
    final displayedPrice = isPriceRange
        ? price
        : (double.tryParse(price) ?? 0.0).toStringAsFixed(2);

    return Text(
      currencySign + displayedPrice,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null,
            )
          : Theme.of(context).textTheme.titleLarge!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null,
            ),
    );
  }
}
