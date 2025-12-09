import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/layouts/grid_layout.dart';
import 'package:magic_hardware/common/widgets/shimmers/shimmer.dart';

/// A widget that displays a shimmering grid of brand placeholders.
class MagicBrandsShimmer extends StatelessWidget {
  /// Creates a [MagicBrandsShimmer] widget.
  const MagicBrandsShimmer({super.key, this.itemCount = 4});

  /// The number of brand placeholders to display.
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return MagicGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, _) => const MagicShimmerEffect(width: 300, height: 80),
    );
  }
}
