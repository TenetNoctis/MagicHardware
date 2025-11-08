import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:magic_hardware/common/widgets/images/magic_rounded_image.dart';
import 'package:magic_hardware/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:magic_hardware/common/widgets/texts/product_price_text.dart';
import 'package:magic_hardware/common/widgets/texts/product_title_text.dart';
import 'package:magic_hardware/utils/constants/image_strings.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../icons/magic_circular_icon.dart';

class MagicProductCardHorizontal extends StatelessWidget {
  const MagicProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MagicSizes.productImageRadius),
        color: dark ? MagicColors.darkerGrey : MagicColors.softGrey,
      ),
      child: Row(
        children: [
          // Thumbnail
          MagicRoundedContainer(
            height: 120,
            padding: EdgeInsets.all(MagicSizes.sm),
            backgroundColor: dark
                ? MagicColors.darkestGrey
                : MagicColors.white.withValues(alpha: 0.6),
            child: Stack(
              children: [
                // Thumbnail Image
                SizedBox(
                  height: 120,
                  width: 120,
                  child: MagicRoundedImage(
                    imageUrl: MagicImages.weldingGlove,
                    applyImageRadius: true,
                  ),
                ),

                // Sale Tag
                Positioned(
                  top: 5,
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
                  top: 0,
                  right: 0,
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

          // Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: MagicSizes.sm,
                left: MagicSizes.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MagicProductTitleText(
                        title: 'Welding Gloves',
                        smallSize: true,
                      ),
                      SizedBox(height: MagicSizes.spaceBtwItems / 2),
                      MagicBrandTitleWithVerifiedIcon(title: 'Vaultex'),
                      SizedBox(height: MagicSizes.spaceBtwItems / 2),
                    ],
                  ),

                  Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Flexible(child: MagicProductPriceText(price: '95.00')),

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
                            child: const Icon(
                              Iconsax.add,
                              color: MagicColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
