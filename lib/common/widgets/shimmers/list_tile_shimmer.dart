import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/shimmers/shimmer.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

/// A widget that displays a shimmering list tile, used as a placeholder while loading data.
class MagicListTileShimmer extends StatelessWidget {
  /// Creates a [MagicListTileShimmer] widget.
  const MagicListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            MagicShimmerEffect(width: 50, height: 50, radius: 50),
            SizedBox(width: MagicSizes.spaceBtwItems),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MagicShimmerEffect(width: 100, height: 15),
                SizedBox(height: MagicSizes.spaceBtwItems / 2),
                MagicShimmerEffect(width: 80, height: 12),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
