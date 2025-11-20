import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/shimmers/shimmer.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

class MagicBoxesShimmer extends StatelessWidget {
  const MagicBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: MagicShimmerEffect(width: 150, height: 110)),
            SizedBox(width: MagicSizes.spaceBtwItems),
            Expanded(child: MagicShimmerEffect(width: 150, height: 110)),
            SizedBox(width: MagicSizes.spaceBtwItems),
            Expanded(child: MagicShimmerEffect(width: 150, height: 110)),
          ],
        )
      ],
    );
  }
}
