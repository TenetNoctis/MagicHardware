import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/features/personalization/controllers/address_controller.dart';
import 'package:magic_hardware/features/personalization/controllers/user_controller.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

/// A widget that displays the billing address section in the checkout screen.
class MagicBillingAddressSection extends StatelessWidget {
  /// Creates a [MagicBillingAddressSection] widget.
  const MagicBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    final userController = UserController.instance;
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MagicSectionHeading(
            title: 'Shipping Address',
            buttonTitle: 'Change',
            onPressed: () => addressController.selectNewAddressPopup(context),
          ),
          addressController.selectedAddress.value.id.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userController.user.value?.fullName ?? 'Guest',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: MagicSizes.spaceBtwItems / 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: MagicColors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: MagicSizes.spaceBtwItems),
                        Text(
                          addressController.selectedAddress.value.phoneNumber,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: MagicSizes.spaceBtwItems / 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_history,
                          color: MagicColors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: MagicSizes.spaceBtwItems),
                        Expanded(
                          child: Text(
                            "${addressController.selectedAddress.value.addressName}, ${addressController.selectedAddress.value.street}, ${addressController.selectedAddress.value.atoll}, ${addressController.selectedAddress.value.island}, ${addressController.selectedAddress.value.postalCode}, ${addressController.selectedAddress.value.landmark}",
                            style: Theme.of(context).textTheme.bodyMedium,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Text(
                  'Please Select Address',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
        ],
      ),
    );
  }
}
