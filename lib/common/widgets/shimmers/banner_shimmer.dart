import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/shimmers/shimmer.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

class MagicBannerShimmer extends StatelessWidget {
  const MagicBannerShimmer({super.key});

  // Shimmer Effect for Banner
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(viewportFraction: 0.65, autoPlay: false),
          items: List.generate(
            3,
            (index) => const MagicShimmerEffect(
              width: 230,
              height: 230,
              radius: MagicSizes.md,
            ),
          ),
        ),
        const SizedBox(height: MagicSizes.spaceBtwItems * 2),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Container(
              width: 20,
              height: 4,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(MagicSizes.md),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
