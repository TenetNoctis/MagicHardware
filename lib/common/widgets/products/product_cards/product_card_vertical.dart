import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:magic_hardware/common/widgets/images/magic_rounded_image.dart';
import 'package:magic_hardware/common/widgets/texts/product_title_text.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../styles/shadows.dart';
import '../../icons/magic_circular_icon.dart';
import '../../texts/product_price_text.dart';

class MagicProductCardVertical extends StatelessWidget {
  const MagicProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [MagicShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(MagicSizes.productImageRadius),
          color: dark ? MagicColors.darkerGrey : MagicColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Thumbnail
            Expanded(
              child: MagicRoundedContainer(
                width: 180,
                padding: const EdgeInsets.all(0),
                backgroundColor: dark
                    ? MagicColors.darkerGrey
                    : MagicColors.light,
                child: Stack(
                  children: [
                    // Thumbnail Image
                    Center(child: MagicRoundedImage(imageUrl: MagicImages.weldingGlove, applyImageRadius: true,)),

                    // Sale Tag
                    Positioned(
                      top: 16,
                      left: 2,
                      child: MagicRoundedContainer(
                        radius: MagicSizes.sm,
                        backgroundColor: MagicColors.secondary.withValues(
                          alpha: 0.8,
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
                      top: 5,
                      right: -10,
                      child: const MagicCircularIcon(
                        icon: Iconsax.heart5,
                        size: MagicSizes.md,
                        color: Colors.red,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: MagicSizes.spaceBtwItems / 2),

            // Details
            Padding(
              padding: const EdgeInsets.only(left: MagicSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MagicProductTitleText(
                    title: 'Welding Gloves',
                    smallSize: true,
                  ),
                  SizedBox(height: MagicSizes.spaceBtwItems / 2),
                  Row(
                    children: [
                      Text(
                        'Vaultex',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(width: MagicSizes.xs),
                      const Icon(
                        Iconsax.verify5,
                        color: MagicColors.primary,
                        size: MagicSizes.iconXs,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MagicProductPriceText(
                        price: '95.00',
                        isLarge: false,
                      ),
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
          ],
        ),
      ),
    );
  }
}
