import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:magic_hardware/common/widgets/images/magic_rounded_image.dart';
import 'package:magic_hardware/common/widgets/texts/product_title_text.dart';
import 'package:magic_hardware/features/shop/controllers/product/product_controller.dart';
import 'package:magic_hardware/utils/constants/enums.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../features/shop/models/product_model.dart';
import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../../../utils/constants/colors.dart';
import '../../../styles/shadows.dart';
import '../../icons/magic_circular_icon.dart';
import '../../texts/brand_title_text_with_verified_icon.dart';
import '../../texts/product_price_text.dart';

class MagicProductCardVertical extends StatelessWidget {
  const MagicProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(
      product.price,
      product.salePrice,
    );
    final dark = MagicHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
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
                  Center(
                    child: MagicRoundedImage(
                      height: 150,
                      width: double.infinity,
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                      backgroundColor: MagicHelperFunctions.isDarkMode(context)
                          ? MagicColors.darkestGrey
                          : MagicColors.light,
                    ),
                  ),

                  // Sale Tag
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      left: 3,
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
                          '$salePercentage%',
                          style: Theme.of(context).textTheme.labelLarge!.apply(
                            color: MagicColors.black,
                          ),
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
                  MagicProductTitleText(title: product.title, smallSize: true),
                  const SizedBox(height: MagicSizes.spaceBtwItems / 2),
                  MagicBrandTitleWithVerifiedIcon(
                    title: product.brand?.name ?? '',
                    brandTextSize: TextSizes.small,
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Price Row

            // Sale Price
            if (product.productType == ProductType.single.toString() &&
                (product.salePrice ?? 0) > 0)
              Padding(
                padding: const EdgeInsets.only(left: MagicSizes.sm),
                child: Text(
                  'MVR ${product.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.labelMedium!.apply(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),

            // Regular Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Price
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: MagicSizes.sm),
                        child: MagicProductPriceText(
                          price: controller.getProductPrice(product),
                          isLarge: false,
                        ),
                      ),
                    ],
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
