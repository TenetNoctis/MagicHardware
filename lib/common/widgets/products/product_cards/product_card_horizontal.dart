import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:magic_hardware/common/widgets/images/magic_rounded_image.dart';
import 'package:magic_hardware/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:magic_hardware/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:magic_hardware/common/widgets/texts/product_price_text.dart';
import 'package:magic_hardware/common/widgets/texts/product_title_text.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../../../features/shop/models/product_model.dart';
import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import 'add_to_cart_button.dart';

/// A widget that displays a product card with a horizontal layout.
class MagicProductCardHorizontal extends StatelessWidget {
  /// Creates a [MagicProductCardHorizontal].
  ///
  /// The [product] model is required to display the product information.
  const MagicProductCardHorizontal({super.key, required this.product});

  /// The product to be displayed in the card.
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
              height: 130,
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
                      imageUrl: product.thumbnail,
                      isNetworkImage: true,
                      applyImageRadius: true,
                    ),
                  ),

                  // Sale Tag
                  if (salePercentage != null)
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
                          '$salePercentage%',
                          style: Theme.of(context).textTheme.labelLarge!.apply(
                            color: MagicColors.black,
                          ),
                        ),
                      ),
                    ),

                  // Favorite Icon Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: MagicFavoriteIcon(productId: product.id),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Product Details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MagicProductTitleText(
                          title: product.title,
                          smallSize: true,
                        ),
                        SizedBox(height: MagicSizes.spaceBtwItems / 3),
                        MagicBrandTitleWithVerifiedIcon(
                          title: product.brand!.name,
                        ),
                      ],
                    ),

                    Spacer(),

                    // Price Row

                    // Regular Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Sale Price
                              if (product.productType ==
                                      ProductType.single.toString() &&
                                  (product.salePrice ?? 0) > 0)
                                Text(
                                  'MVR ${product.price.toStringAsFixed(2)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .apply(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                              MagicProductPriceText(
                                price: controller.getProductPrice(product),
                                isLarge: false,
                              ),
                            ],
                          ),
                        ),

                        // Add to Cart
                        ProductCardAddToCartButton(product: product),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
