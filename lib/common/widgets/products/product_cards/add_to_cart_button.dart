import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/features/shop/controllers/product/cart_controller.dart';
import 'package:magic_hardware/utils/constants/enums.dart';

import '../../../../features/shop/models/product_model.dart';
import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/popups/loaders.dart';

/// A button that adds a product to the cart, showing the quantity if it's already in the cart.
class ProductCardAddToCartButton extends StatelessWidget {
  /// Creates a [ProductCardAddToCartButton].
  const ProductCardAddToCartButton({super.key, required this.product});

  /// The product associated with this button.
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return InkWell(
      onTap: () {
        if (product.productType == ProductType.single.toString()) {
          final currentQuantity = cartController.getProductQuantityInCart(
            product.id,
          );
          if (currentQuantity >= product.stock) {
            MagicLoaders.warningSnackBar(
              title: 'Oh Snap!',
              message: 'No more stock available.',
            );
            return;
          }
          final cartItem = cartController.convertToCartItem(product, 1);
          cartController.addOneToCart(cartItem);
        } else {
          Get.to(() => ProductDetailScreen(product: product));
        }
      },
      child: Obx(() {
        final productQuantityInCart = cartController.getProductQuantityInCart(
          product.id,
        );
        return Container(
          decoration: BoxDecoration(
            color: productQuantityInCart > 0
                ? MagicColors.primary
                : MagicColors.darkestGrey,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(MagicSizes.cardRadiusMd),
              bottomRight: Radius.circular(MagicSizes.productImageRadius),
            ),
          ),
          child: SizedBox(
            width: MagicSizes.iconLg * 1.2,
            height: MagicSizes.iconLg * 1.2,
            child: Center(
              child: productQuantityInCart > 0
                  ? Text(
                      productQuantityInCart.toString(),
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.apply(color: Colors.white),
                    )
                  : const Icon(Iconsax.add, color: MagicColors.white),
            ),
          ),
        );
      }),
    );
  }
}
