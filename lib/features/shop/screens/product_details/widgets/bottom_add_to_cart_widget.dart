import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/icons/magic_circular_icon.dart';
import 'package:magic_hardware/features/shop/controllers/product/cart_controller.dart';
import 'package:magic_hardware/features/shop/models/product_model.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/enums.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

/// A widget that displays a bottom navigation bar with an "Add to Cart" button.
class MagicBottomAddToCart extends StatelessWidget {
  /// Creates a [MagicBottomAddToCart] widget.
  const MagicBottomAddToCart({super.key, required this.product});

  /// The product to be added to the cart.
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    final dark = MagicHelperFunctions.isDarkMode(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MagicSizes.defaultSpace,
        vertical: MagicSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? MagicColors.darkerGrey : MagicColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MagicSizes.borderRadiusLg),
          topRight: Radius.circular(MagicSizes.borderRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            // Get available stock based on product type
            final availableStock =
                product.productType == ProductType.variable.toString()
                ? controller.variationController.selectedVariation.value.stock
                : product.stock;

            final currentQuantity = controller.productQuantityInCart.value;
            final canIncrement = currentQuantity < availableStock;

            return Row(
              children: [
                // Minus Button
                MagicCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: currentQuantity < 1
                      ? MagicColors.darkGrey
                      : MagicColors.black,
                  width: 40,
                  height: 40,
                  color: MagicColors.white,
                  onPressed: currentQuantity < 1
                      ? null
                      : () => controller.productQuantityInCart.value -= 1,
                ),
                const SizedBox(width: MagicSizes.spaceBtwItems),

                // Quantity Display
                Text(
                  currentQuantity.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: MagicSizes.spaceBtwItems),

                // Plus Button
                MagicCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: canIncrement
                      ? MagicColors.black
                      : MagicColors.darkGrey,
                  width: 40,
                  height: 40,
                  color: MagicColors.white,
                  onPressed: canIncrement
                      ? () => controller.productQuantityInCart.value += 1
                      : null,
                ),
              ],
            );
          }),

          // Add to Cart Button
          Obx(
            () => ElevatedButton(
              onPressed: controller.productQuantityInCart.value < 1
                  ? null
                  : () => controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(MagicSizes.md),
                backgroundColor: MagicColors.black,
                foregroundColor: MagicColors.white,
                disabledBackgroundColor: MagicColors.darkGrey,
                disabledForegroundColor: MagicColors.white,
                side: BorderSide(
                  color: controller.productQuantityInCart.value < 1
                      ? MagicColors.darkerGrey
                      : MagicColors.black,
                ),
              ),
              child: const Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
