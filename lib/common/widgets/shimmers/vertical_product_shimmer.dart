import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/layouts/grid_layout.dart';
import 'package:magic_hardware/common/widgets/shimmers/shimmer.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

/// A widget that displays a vertical list of shimmering product placeholders.
class MagicVerticalProductShimmer extends StatelessWidget {
  /// Creates a [MagicVerticalProductShimmer] widget.
  const MagicVerticalProductShimmer({super.key, this.itemCount = 4});

  /// The number of product placeholders to display.
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return MagicGridLayout(
      itemCount: itemCount,
      itemBuilder: (_, _) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            MagicShimmerEffect(width: 180, height: 180),
            SizedBox(height: MagicSizes.spaceBtwItems),

            // Texts
            MagicShimmerEffect(width: 160, height: 15),
            SizedBox(height: MagicSizes.spaceBtwItems / 2),
            MagicShimmerEffect(width: 110, height: 15),
          ],
        ),
      ),
    );
  }
}
