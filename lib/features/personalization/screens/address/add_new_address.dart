import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MagicAppBar(title: Text('Add New Address'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MagicSizes.defaultSpace),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                const SizedBox(height: MagicSizes.spaceBtwInputFields),
                TextFormField(
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
                        decoration: InputDecoration(
                          labelText: 'Street',
                          prefixIcon: Icon(Iconsax.building),
                        ),
                      ),
                    ),
                    const SizedBox(width: MagicSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
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
                        decoration: InputDecoration(
                          labelText: 'Island',
                          prefixIcon: Icon(Iconsax.map_1),
                        ),
                      ),
                    ),
                    const SizedBox(width: MagicSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
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
                  decoration: InputDecoration(
                    labelText: 'Landmark',
                    prefixIcon: Icon(Iconsax.building_3),
                  ),
                ),
                const SizedBox(height: MagicSizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    child: Text('Save'),
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
