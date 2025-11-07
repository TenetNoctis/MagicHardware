import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/common/widgets/texts/product_price_text.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

import '../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../common/widgets/products/cart/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MagicAppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(MagicSizes.defaultSpace),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: 10,
          separatorBuilder: (_, _) =>
              const SizedBox(height: MagicSizes.spaceBtwSections),
          itemBuilder: (_, index) => Column(
            children: [
              MagicCartItem(),
              SizedBox(height: MagicSizes.spaceBtwItems),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Spacer
                      SizedBox(width: 70),
                      // Add/Remove Buttons
                      MagicProductQuantityWithAddRemoveButton(),
                    ],
                  ),
                  MagicProductPriceText(price: '71.25'),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(MagicSizes.defaultSpace),
        child: ElevatedButton(onPressed: (){}, child: Text('Checkout MVR 71.25')),
      ),
    );
  }
}
