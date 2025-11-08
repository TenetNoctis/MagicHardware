import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:magic_hardware/common/widgets/success_screen/success_screen.dart';
import 'package:magic_hardware/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:magic_hardware/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:magic_hardware/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:magic_hardware/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:magic_hardware/navigation_menu.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/image_strings.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/cart/coupon_widget.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Scaffold(
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
              MagicAllCartItems(showAddRemoveButtons: false, physics: const NeverScrollableScrollPhysics()),
              SizedBox(height: MagicSizes.spaceBtwSections),

              // Coupon
              MagicCouponCode(),
              SizedBox(height: MagicSizes.spaceBtwSections),

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
          onPressed: () => Get.to(
            () => SuccessScreen(
              image: MagicImages.successfulPaymentIcon,
              title: 'Payment Success!',
              subTitle: 'Your items will be shipped soon',
              onPressed: () => Get.offAll(() => const NavigationMenu()),
            ),
          ),
          child: Text('Checkout MVR 71.25'),
        ),
      ),
    );
  }
}
