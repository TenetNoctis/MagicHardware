import 'package:flutter/material.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

class MagicBillingAmountSection extends StatelessWidget {
  const MagicBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium,),
            Text('MVR 71.25', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: MagicSizes.spaceBtwItems / 2),

        // Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium,),
            Text('MVR 10.00', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: MagicSizes.spaceBtwItems / 2),

        // Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee (GST 8%)', style: Theme.of(context).textTheme.bodyMedium,),
            Text('MVR 6.50', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: MagicSizes.spaceBtwItems / 2),
        Divider(),
        // Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium,),
            Text('MVR 87.75', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}
