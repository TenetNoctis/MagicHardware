import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/features/shop/controllers/product/all_products_controller.dart';
import 'package:magic_hardware/features/shop/models/product_model.dart';

import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

/// A widget that provides a sortable list of products.
class MagicSortableProducts extends StatelessWidget {
  /// Creates a [MagicSortableProducts] widget.
  ///
  /// The [products] are required to be displayed.
  const MagicSortableProducts({super.key, required this.products});

  /// The list of products to be sorted.
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AllProductsController>();
    controller.assignProducts(products);
    return Column(
      children: [
        // Dropdown
        DropdownButtonFormField(
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          initialValue: controller.selectedSortOption.value,
          onChanged: (value) {
            // Sort products based on selected option
            controller.sortProducts(value!);
          },
          items:
              [
                    'Name',
                    'Price: High to Low',
                    'Price: Low to High',
                    'On Sale',
                    //'Newest',
                    //'Popularity',
                  ]
                  .map(
                    (option) =>
                        DropdownMenuItem(value: option, child: Text(option)),
                  )
                  .toList(),
        ),
        const SizedBox(height: MagicSizes.spaceBtwSections),
        // Products
        Obx(
          () => MagicGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (_, index) =>
                MagicProductCardVertical(product: controller.products[index]),
          ),
        ),
      ],
    );
  }
}
