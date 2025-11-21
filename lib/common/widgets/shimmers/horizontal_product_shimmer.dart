import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/shimmers/shimmer.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

class MagicHorizontalProductShimmer extends StatelessWidget {
  const MagicHorizontalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MagicSizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) =>
            const SizedBox(width: MagicSizes.spaceBtwItems),
        itemBuilder: (_, _) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image
            MagicShimmerEffect(width: 120, height: 120),
            SizedBox(width: MagicSizes.spaceBtwItems),

            // Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MagicSizes.spaceBtwItems / 2),
                MagicShimmerEffect(width: 160, height: 15),
                SizedBox(height: MagicSizes.spaceBtwItems / 2),
                MagicShimmerEffect(width: 110, height: 15),
                SizedBox(height: MagicSizes.spaceBtwItems / 2),
                MagicShimmerEffect(width: 80, height: 15),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
