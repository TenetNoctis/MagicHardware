import 'package:flutter/material.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

class MagicAllCartItems extends StatelessWidget {
  const MagicAllCartItems({
    super.key,
    this.showAddRemoveButtons = true,
    this.physics = const AlwaysScrollableScrollPhysics(),
  });

  final bool showAddRemoveButtons;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: physics,
      shrinkWrap: true,
      itemCount: 10,
      separatorBuilder: (_, _) =>
          const SizedBox(height: MagicSizes.spaceBtwSections),
      itemBuilder: (_, index) => Column(
        children: [
          MagicCartItem(),
          if (showAddRemoveButtons)
            const SizedBox(height: MagicSizes.spaceBtwItems),

          if (showAddRemoveButtons)
            const Row(
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

                // Product Total Price
                MagicProductPriceText(price: '71.25'),
              ],
            ),
        ],
      ),
    );
  }
}
