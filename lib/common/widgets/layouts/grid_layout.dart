import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';

/// A widget that displays a grid of items with a specified count and builder.
class MagicGridLayout extends StatelessWidget {
  /// Creates a grid layout.
  const MagicGridLayout({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.mainAxisExtent = 288,
  });

  /// The number of items in the grid.
  final int itemCount;

  /// The extent of the main axis.
  final double? mainAxisExtent;

  /// A builder function to create the items in the grid.
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: mainAxisExtent,
        mainAxisSpacing: MagicSizes.gridViewSpacing,
        crossAxisSpacing: MagicSizes.gridViewSpacing,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
