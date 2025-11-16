import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/features/shop/models/product_model.dart';

import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class MagicSortableProducts extends StatelessWidget {
  const MagicSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dropdown
        DropdownButtonFormField(
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {},
          items:
          ['Name', 'Price: High to Low', 'Price: Low to High', 'On Sale', 'Newest', 'Popularity',]
              .map((option) => DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: MagicSizes.spaceBtwSections),
        // Products
        MagicGridLayout(itemCount: 10, itemBuilder: (_, index) => MagicProductCardVertical(product: ProductModel.empty()))
      ],
    );
  }
}
