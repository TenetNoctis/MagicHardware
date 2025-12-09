import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:magic_hardware/features/shop/screens/checkout/checkout.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../controllers/product/cart_controller.dart';
import '../../controllers/product/product_controller.dart';
import '../all_products/all_products.dart';

/// A screen that displays the contents of the user's shopping cart.
class CartScreen extends StatelessWidget {
  /// Creates a [CartScreen] widget.
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: MagicAppBar(
          title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
          showBackArrow: true,
        ),
        body: Obx(() {
          final emptyWidget = MagicAnimationLoaderWidget(
            text: 'Whoops! Cart is empty...',
            showAction: true,
            actionText: 'Explore Products',
            animation: MagicImages.emptyAnimation,
            width: 0.5,
            onActionPressed: () => Get.to(
              () => AllProductsScreen(
                title: 'All Products',
                futureMethod: ProductController.instance.fetchAllProducts(),
              ),
            ),
          );

          if (controller.cartItems.isEmpty) {
            return emptyWidget;
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(MagicSizes.defaultSpace),

                // Items in Cart
                child: MagicAllCartItems(),
              ),
            );
          }
        }),

        // Checkout Button
        bottomNavigationBar: controller.cartItems.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.all(MagicSizes.defaultSpace),
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const CheckoutScreen()),
                  child: Obx(
                    () => Text(
                      'Checkout MVR ${controller.totalCartPrice.value.toStringAsFixed(2)}',
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
