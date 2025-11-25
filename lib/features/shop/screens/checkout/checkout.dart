import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:magic_hardware/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:magic_hardware/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:magic_hardware/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:magic_hardware/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';
import 'package:magic_hardware/utils/popups/loaders.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../controllers/product/cart_controller.dart';
import '../../controllers/product/order_controller.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = MagicPricingCalculator.calculateSubTotal(cartController.totalCartPrice.value, 'Maldives');
    final totalAmount = MagicPricingCalculator.calculateTotalPrice(subTotal, 'Maldives');
    final orderController = Get.put(OrderController());

    final dark = MagicHelperFunctions.isDarkMode(context);

    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: MagicAppBar(
          title: Text(
            'Order Review',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(MagicSizes.defaultSpace),
            child: Column(
              children: [
                // Items in Cart
                MagicAllCartItems(showAddRemoveButtons: false),
                const SizedBox(height: MagicSizes.spaceBtwSections),

                // Coupon
                MagicCouponCode(),
                const SizedBox(height: MagicSizes.spaceBtwSections),

                // Billing
                MagicRoundedContainer(
                  showBorder: true,
                  padding: EdgeInsets.all(MagicSizes.md),
                  backgroundColor: dark ? MagicColors.black : MagicColors.white,
                  child: Column(
                    children: [
                      // Pricing
                      MagicBillingAmountSection(),

                      // Divider
                      Divider(),

                      // Payment Methods
                      MagicBillingPaymentSection(),
                      SizedBox(height: MagicSizes.spaceBtwItems),

                      // Address
                      MagicBillingAddressSection(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Checkout Button
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(MagicSizes.defaultSpace),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: MagicColors.primary,
                side: BorderSide(color: MagicColors.primary)
            ),
            onPressed: subTotal > 0 ?
            () => orderController.processOrder(totalAmount) :
            () => MagicLoaders.warningSnackBar(title: 'Empty Cart', message: 'Add items in the cart in order to proceed'),
            child: Text('Checkout MVR ${totalAmount.toStringAsFixed(2)}'),
          ),
        ),
      ),
    );
  }
}
