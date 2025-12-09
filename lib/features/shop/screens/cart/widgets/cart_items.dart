import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/features/shop/controllers/product/cart_controller.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

/// A widget that displays all items in the cart.
class MagicAllCartItems extends StatelessWidget {
  /// Creates a [MagicAllCartItems] widget.
  const MagicAllCartItems({super.key, this.showAddRemoveButtons = true});

  /// Whether to show the add and remove buttons.
  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemCount: cartController.cartItems.length,
        separatorBuilder: (_, _) =>
            const SizedBox(height: MagicSizes.spaceBtwSections),
        itemBuilder: (_, index) => Obx(() {
          final item = cartController.cartItems[index];
          return Column(
            children: [
              MagicCartItem(
                cartItem: item,
                showQuantity: !showAddRemoveButtons,
              ),
              if (showAddRemoveButtons) ...[
                const SizedBox(height: MagicSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Spacer
                        const SizedBox(width: 70),

                        // Add/Remove Buttons
                        MagicProductQuantityWithAddRemoveButton(
                          quantity: item.quantity,
                          add: () => cartController.addOneToCart(item),
                          remove: () => cartController.removeOneFromCart(item),
                        ),
                      ],
                    ),

                    // Product Total Price
                    MagicProductPriceText(
                      price: (item.price * item.quantity).toStringAsFixed(2),
                    ),
                  ],
                ),
              ],
            ],
          );
        }),
      ),
    );
  }
}
