import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/features/personalization/controllers/address_controller.dart';
import 'package:magic_hardware/features/personalization/models/address_model.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';

/// A widget that displays a single address with an option to delete.
class MagicSingleAddress extends StatelessWidget {
  /// Creates a [MagicSingleAddress] widget.
  const MagicSingleAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  /// The address to display.
  final AddressModel address;

  /// The callback function to be called when the address is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    final dark = MagicHelperFunctions.isDarkMode(context);
    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;
      return Slidable(
        key: ValueKey(address.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => controller.deleteAddress(address.id),
              backgroundColor: Colors.transparent,
              foregroundColor: dark ? MagicColors.white : MagicColors.black,
              icon: Iconsax.trash,
              label: 'Delete',
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          child: MagicRoundedContainer(
            padding: EdgeInsets.all(MagicSizes.md),
            width: double.infinity,
            showBorder: true,
            backgroundColor: selectedAddress
                ? MagicColors.primary.withValues(alpha: 0.5)
                : Colors.transparent,
            borderColor: selectedAddress
                ? Colors.transparent
                : dark
                ? MagicColors.darkerGrey
                : MagicColors.grey,
            margin: EdgeInsets.only(bottom: MagicSizes.spaceBtwItems),
            child: Stack(
              children: [
                Positioned(
                  right: 5,
                  top: 0,
                  child: Icon(
                    selectedAddress ? Iconsax.tick_circle5 : null,
                    color: selectedAddress
                        ? dark
                              ? MagicColors.light
                              : MagicColors.dark.withValues(alpha: 0.6)
                        : null,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.addressName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: MagicSizes.sm),
                    Text(
                      address.formattedPhoneNo,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: MagicSizes.sm / 2),
                    Text(address.toString(), softWrap: true),
                    if (address.landmark != null &&
                        address.landmark!.isNotEmpty) ...[
                      const SizedBox(height: MagicSizes.sm / 2),
                      Text(
                        address.landmark.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
