import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

import '../../../controllers/update_gender_controller.dart';

/// A screen that allows the user to change their gender.
class ChangeGender extends StatelessWidget {
  /// Creates a [ChangeGender] widget.
  const ChangeGender({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateGenderController());
    return Scaffold(
      appBar: MagicAppBar(
        showBackArrow: true,
        title: Text(
          'Change Gender',
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
              'Select your gender',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: MagicSizes.spaceBtwSections),

            // Gender Options
            Obx(
              () => RadioGroup<String>(
                groupValue: controller.selectedGender.value,
                onChanged: (String? value) {
                  controller.selectedGender.value = value!;
                },
                child: Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text('Male'),
                      value: 'Male',
                      secondary: const Icon(Iconsax.man),
                    ),
                    RadioListTile<String>(
                      title: const Text('Female'),
                      value: 'Female',
                      secondary: const Icon(Iconsax.woman),
                    ),
                    RadioListTile<String>(
                      title: const Text('Prefer Not To Say'),
                      value: 'Other',
                      secondary: const Icon(Iconsax.user),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: MagicSizes.spaceBtwSections),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateGender(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
