import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/validators/validation.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../controllers/update_dob_controller.dart';

class ChangeDob extends StatelessWidget {
  const ChangeDob({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateDobController());
    return Scaffold(
      appBar: MagicAppBar(
        showBackArrow: true,
        title: Text(
          'Change Date of Birth',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(MagicSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headings
            Text(
              'You must be 18 years or older',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: MagicSizes.spaceBtwSections),

            // Text Field
            Form(
              key: controller.updateDobFormKey,
              child: TextFormField(
                controller: controller.dateOfBirth,
                validator: (value) => MagicValidator.validateAge(value),
                expands: false,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  prefixIcon: Icon(Iconsax.calendar),
                  hintText: 'dd-MMM-yyyy',
                ),
                onTap: () => controller.selectDate(context),
              ),
            ),
            const SizedBox(height: MagicSizes.spaceBtwSections),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: MagicColors.primary,
                    side: BorderSide(color: MagicColors.primary)
                ),
                onPressed: () => controller.updateDateOfBirth(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}