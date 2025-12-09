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

/// A widget to display a brand and a preview of its products.
class MagicBrandShowcase extends StatelessWidget {
  /// Creates a [MagicBrandShowcase].
  ///
  /// - [brand]: The brand to showcase.
  /// - [images]: A list of product image URLs to display.
  const MagicBrandShowcase({
    super.key,
    required this.images,
    required this.brand,
  });

  /// The brand to showcase.
  final BrandModel brand;

  /// A list of product image URLs to display as a preview.
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
            MagicBrandCard(brand: brand, showBorder: false),
            const SizedBox(height: MagicSizes.spaceBtwItems),
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

  /// A helper widget to display a single top product image.
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
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              const MagicShimmerEffect(width: 100, height: 100),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
