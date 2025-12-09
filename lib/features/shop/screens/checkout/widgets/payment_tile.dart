import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:magic_hardware/features/shop/controllers/product/checkout_controller.dart';
import 'package:magic_hardware/features/shop/models/payment_method_model.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

/// A widget that displays a payment method tile.
class MagicPaymentTile extends StatelessWidget {
  /// Creates a [MagicPaymentTile].
  const MagicPaymentTile({super.key, required this.paymentMethod});

  /// The payment method to be displayed.
  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    final dark = MagicHelperFunctions.isDarkMode(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      leading: MagicRoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: dark ? MagicColors.light : MagicColors.white,
        padding: EdgeInsets.all(MagicSizes.sm),
        child: Image(
          image: AssetImage(paymentMethod.image),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
