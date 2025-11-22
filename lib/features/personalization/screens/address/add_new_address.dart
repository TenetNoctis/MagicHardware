import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/features/personalization/controllers/address_controller.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/validators/validation.dart';

import '../../../../utils/constants/colors.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    return Scaffold(
      appBar: MagicAppBar(title: Text('Add New Address'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MagicSizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.address,
                  validator: (value) => MagicValidator.validateEmptyText('Address', value),
                  decoration: InputDecoration(
                    labelText: 'Address',
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                const SizedBox(height: MagicSizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) => MagicValidator.validatePhoneNumberFormat(value),
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Iconsax.mobile),
                  ),
                ),
                const SizedBox(height: MagicSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator: (value) => MagicValidator.validateEmptyText('Street', value),
                        decoration: InputDecoration(
                          labelText: 'Street',
                          prefixIcon: Icon(Iconsax.building),
                        ),
                      ),
                    ),
                    const SizedBox(width: MagicSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value) => MagicValidator.validatePostalCode(value),
                        decoration: InputDecoration(
                          labelText: 'Postal Code',
                          prefixIcon: Icon(Iconsax.signpost),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: MagicSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.island,
                        validator: (value) => MagicValidator.validateEmptyText('Island', value),
                        decoration: InputDecoration(
                          labelText: 'Island',
                          prefixIcon: Icon(Iconsax.map_1),
                        ),
                      ),
                    ),
                    const SizedBox(width: MagicSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.atoll,
                        validator: (value) => MagicValidator.validateEmptyText('Atoll', value),
                        decoration: InputDecoration(
                          labelText: 'Atoll',
                          prefixIcon: Icon(Iconsax.routing),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: MagicSizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.landmark,
                  decoration: InputDecoration(
                    labelText: 'Landmark',
                    prefixIcon: Icon(Iconsax.building_3),
                  ),
                ),
                const SizedBox(height: MagicSizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MagicColors.primary,
                      side: BorderSide(color: MagicColors.primary)
                    ),
                    onPressed: () => controller.addNewAddress(),
                    child: Text('Save Address'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
