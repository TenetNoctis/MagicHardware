import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/features/shop/controllers/product/cart_controller.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../features/shop/screens/cart/cart.dart';
import '../../../../utils/constants/colors.dart';

/// A widget that displays a cart icon with a counter that navigates to the cart screen.
class MagicCartCounterIcon extends StatelessWidget {
  /// Creates a [MagicCartCounterIcon] widget.
  const MagicCartCounterIcon({
    super.key,
    this.iconColor,
    this.counterTextColor,
    this.counterBgColor,
  });

  /// The color of the cart icon.
  final Color? iconColor;

  /// The color of the counter's text.
  final Color? counterTextColor;

  /// The background color of the counter.
  final Color? counterBgColor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    final dark = MagicHelperFunctions.isDarkMode(context);

    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const CartScreen()),
          icon: const Icon(Iconsax.shopping_bag),
          color: iconColor,
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color:
                  counterBgColor ??
                  (dark ? MagicColors.white : MagicColors.black),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Obx(
                () => Text(
                  controller.noOfCartItems.value.toString(),
                  style: Theme.of(context).textTheme.labelLarge!.apply(
                    color:
                        counterTextColor ??
                        (dark ? MagicColors.black : MagicColors.white),
                    fontSizeFactor: 0.8,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
