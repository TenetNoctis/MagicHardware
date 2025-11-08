import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

class MagicBillingAddressSection extends StatelessWidget {
  const MagicBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MagicSectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () {},
        ),
        Text('Magic Hardware', style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: MagicSizes.spaceBtwItems / 2),

        Row(
          children: [
            const Icon(Icons.phone, color: MagicColors.grey, size: 16),
            const SizedBox(width: MagicSizes.spaceBtwSections),
            Text(
              '+960 979-8043',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: MagicSizes.spaceBtwItems / 2),

        Row(
          children: [
            const Icon(Icons.location_history, color: MagicColors.grey, size: 16),
            const SizedBox(width: MagicSizes.spaceBtwSections),
            Expanded(
              child: Text(
                "M. Zebra, Buruzu Magu, Male', 20721, Maldives",
                style: Theme.of(context).textTheme.bodyMedium,
                softWrap: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: MagicSizes.spaceBtwItems / 2),
      ],
    );
  }
}
