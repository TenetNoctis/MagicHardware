import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:magic_hardware/common/widgets/images/magic_rounded_image.dart';
import 'package:magic_hardware/common/widgets/texts/product_title_text.dart';
import 'package:magic_hardware/utils/constants/enums.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../styles/shadows.dart';
import '../../icons/magic_circular_icon.dart';
import '../../texts/brand_title_text_with_verified_icon.dart';
import '../../texts/product_price_text.dart';

class MagicProductCardVertical extends StatelessWidget {
  const MagicProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => const ProductDetailScreen()),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          boxShadow: [MagicShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(MagicSizes.productImageRadius),
          color: dark ? MagicColors.darkerGrey : MagicColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            MagicRoundedContainer(
              padding: const EdgeInsets.all(0),
              backgroundColor: dark
                  ? MagicColors.darkerGrey
                  : MagicColors.light,
              child: Stack(
                children: [
                  // Thumbnail Image
                  MagicRoundedImage(
                    imageUrl: MagicImages.weldingGlove,
                    applyImageRadius: true,
                    backgroundColor: MagicHelperFunctions.isDarkMode(context)
                        ? MagicColors.darkestGrey
                        : MagicColors.light,
                  ),

                  // Sale Tag
                  Positioned(
                    top: 12,
                    child: MagicRoundedContainer(
                      radius: MagicSizes.sm,
                      backgroundColor: MagicColors.secondary.withValues(
                        alpha: 0.5,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: MagicSizes.xs,
                        vertical: MagicSizes.xs,
                      ),
                      child: Text(
                        '-25%',
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge!.apply(color: MagicColors.black),
                      ),
                    ),
                  ),

                  // Favorite Icon Button
                  Positioned(
                    top: 6,
                    right: 1,
                    child: const MagicCircularIcon(
                      width: 40,
                      height: 40,
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: MagicSizes.spaceBtwItems / 2),

            // Details
            Padding(
              padding: const EdgeInsets.only(left: MagicSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MagicProductTitleText(title: 'Welding Gloves', smallSize: true),
                  SizedBox(height: MagicSizes.spaceBtwItems / 2),
                  MagicBrandTitleWithVerifiedIcon(title: 'Vaultex', brandTextSize: TextSizes.small),
                ],
              ),
            ),

            const Spacer(),

            // Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              // Price
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: MagicSizes.sm),
                  child: const MagicProductPriceText(
                    price: '95.00',
                    isLarge: false,
                  ),
                ),

                // Add to Cart
                Container(
                  decoration: const BoxDecoration(
                    color: MagicColors.darkestGrey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(MagicSizes.cardRadiusMd),
                      bottomRight: Radius.circular(
                        MagicSizes.productImageRadius,
                      ),
                    ),
                  ),
                  child: SizedBox(
                    width: MagicSizes.iconLg * 1.2,
                    height: MagicSizes.iconLg * 1.2,
                    child: Center(
                      child: const Icon(Iconsax.add, color: MagicColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
