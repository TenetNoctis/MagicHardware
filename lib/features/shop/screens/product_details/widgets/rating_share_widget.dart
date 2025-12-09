import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';

/// A widget that displays the rating and share button for a product.
class MagicRatingsAndShare extends StatelessWidget {
  /// Creates a [MagicRatingsAndShare] widget.
  const MagicRatingsAndShare({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Rating
        Row(
          children: [
            const Icon(Iconsax.star5, color: Colors.amber, size: 24),
            const SizedBox(width: MagicSizes.spaceBtwItems / 2),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '5.0 ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const TextSpan(text: '(199)'),
                ],
              ),
            ),
          ],
        ),

        // Share
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.share, size: MagicSizes.iconMd),
        ),
      ],
    );
  }
}
