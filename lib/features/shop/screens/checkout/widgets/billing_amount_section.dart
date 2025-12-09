import 'package:flutter/material.dart';
import 'package:magic_hardware/features/shop/controllers/product/cart_controller.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/pricing_calculator.dart';

/// A widget that displays the billing amount section in the checkout screen.
class MagicBillingAmountSection extends StatelessWidget {
  /// Creates a [MagicBillingAmountSection] widget.
  const MagicBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = MagicPricingCalculator.calculateSubTotal(
      cartController.totalCartPrice.value,
      'Maldives',
    );
    return Column(
      children: [
        // Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Text(
              'MVR ${subTotal.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: MagicSizes.spaceBtwItems / 2),

        // Shipping Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text(
              'MVR ${MagicPricingCalculator.calculateShippingCost(subTotal, 'Maldives')}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: MagicSizes.spaceBtwItems / 2),

        // Tax Fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tax Fee (GST 8%)',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'MVR ${MagicPricingCalculator.calculateTax(subTotal, 'Maldives')}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const SizedBox(height: MagicSizes.spaceBtwItems / 2),
        const Divider(),
        // Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order Total', style: Theme.of(context).textTheme.bodyMedium),
            Text(
              'MVR ${MagicPricingCalculator.calculateTotalPrice(subTotal, 'Maldives').toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }
}
