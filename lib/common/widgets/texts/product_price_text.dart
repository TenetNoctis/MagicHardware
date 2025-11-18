import 'package:flutter/material.dart';

class MagicProductPriceText extends StatelessWidget {
  const MagicProductPriceText({
    super.key,
    this.currencySign = 'MVR ',
    required this.price,
    this.isLarge = false,
    this.maxLines = 1,
    this.lineThrough = false,
  });

  final String currencySign, price;
  final int maxLines;
  final bool isLarge;
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
          ? Theme.of(context).textTheme.headlineMedium!.apply(decoration: lineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.titleLarge!.apply(decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}