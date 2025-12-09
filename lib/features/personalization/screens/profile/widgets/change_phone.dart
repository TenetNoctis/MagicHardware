import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/validators/validation.dart';

import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/update_phone_controller.dart';

/// A screen that allows a user to change their phone number.
class ChangePhone extends StatelessWidget {
  /// Creates a [ChangePhone] screen.
  const ChangePhone({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneController());
    return Scaffold(
      appBar: MagicAppBar(
        showBackArrow: true,
        title: Text(
          'Change Phone Number',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(MagicSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headings
            Text(
              'Update your phone number for account security!',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: MagicSizes.spaceBtwSections),

            // Text Field
            Form(
              key: controller.updatePhoneFormKey,
              child: TextFormField(
                controller: controller.phoneNumber,
                validator: (value) =>
                    MagicValidator.validatePhoneNumberFormat(value),
                expands: false,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: MagicTexts.phoneNo,
                  prefixIcon: Icon(Iconsax.call),
                  hintText: '7 digits',
                ),
              ),
            ),
            const SizedBox(height: MagicSizes.spaceBtwSections),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updatePhoneNumber(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
