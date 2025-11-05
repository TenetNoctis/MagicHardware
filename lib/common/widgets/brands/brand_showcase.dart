import 'package:flutter/material.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import 'brand_card.dart';

class MagicBrandShowcase extends StatelessWidget {
  const MagicBrandShowcase({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return MagicRoundedContainer(
      showBorder: true,
      borderColor: MagicColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(MagicSizes.md),
      margin: const EdgeInsets.only(bottom: MagicSizes.spaceBtwItems),
      child: Column(
        children: [
          // Brand with products count
          MagicBrandCard(
            brand: BrandModel(
              image: MagicImages.weldingIcon,
              name: 'Welding',
              productsCount: 256,
            ),
            showBorder: false,
          ),
          const SizedBox(height: MagicSizes.spaceBtwItems),
          // Brand Top 3 Product Images
          Row(
            children: images
                .map((image) => brandTopProductImageWidget(image, context))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
      child: MagicRoundedContainer(
        height: 100,
        backgroundColor: MagicHelperFunctions.isDarkMode(context)
            ? MagicColors.darkerGrey
            : MagicColors.light,
        margin: const EdgeInsets.only(right: MagicSizes.sm),
        padding: const EdgeInsets.all(MagicSizes.md),
        child: Image(
          fit: BoxFit.contain,
          image: AssetImage(image),
        ),
      ),
    );
  }
}
