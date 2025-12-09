import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../controllers/product/checkout_controller.dart';

/// A widget that displays the billing payment section.
class MagicBillingPaymentSection extends StatelessWidget {
  /// Creates a new [MagicBillingPaymentSection] widget.
  const MagicBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        MagicSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const SizedBox(height: MagicSizes.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              MagicRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? MagicColors.light : MagicColors.white,
                padding: EdgeInsets.all(MagicSizes.sm),
                child: Image(
                  image: AssetImage(
                    controller.selectedPaymentMethod.value.image,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: MagicSizes.spaceBtwItems / 2),
              Text(
                controller.selectedPaymentMethod.value.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
