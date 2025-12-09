import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/shimmers/shimmer.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

/// A widget that displays a shimmering list of category placeholders.
class MagicCategoryShimmer extends StatelessWidget {
  /// Creates a [MagicCategoryShimmer] widget.
  const MagicCategoryShimmer({super.key, this.itemCount = 6});

  /// The number of category placeholders to display.
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, _) =>
            const SizedBox(width: MagicSizes.spaceBtwItems),
        itemBuilder: (_, _) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              MagicShimmerEffect(width: 55, height: 55, radius: 55),
              SizedBox(height: MagicSizes.spaceBtwItems / 2),

              // Text
              MagicShimmerEffect(width: 55, height: 8),
            ],
          );
        },
      ),
    );
  }
}
