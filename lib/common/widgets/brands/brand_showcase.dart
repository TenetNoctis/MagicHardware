import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/shimmers/shimmer.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../features/shop/screens/brand/brand_products.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import 'brand_card.dart';

class MagicBrandShowcase extends StatelessWidget {
  const MagicBrandShowcase({super.key, required this.images, required this.brand});

  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: MagicRoundedContainer(
        showBorder: true,
        borderColor: MagicColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(MagicSizes.md),
        margin: const EdgeInsets.only(bottom: MagicSizes.spaceBtwItems),
        child: Column(
          children: [
            // Brand with products count
            MagicBrandCard(
              brand: brand,
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
        child: CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: image,
          progressIndicatorBuilder: (context, url, downloadProgress) => const MagicShimmerEffect(width: 100, height: 100),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        )
      ),
    );
  }
}
