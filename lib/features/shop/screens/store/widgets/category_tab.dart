import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/layouts/grid_layout.dart';
import 'package:magic_hardware/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/features/shop/controllers/category_controller.dart';
import 'package:magic_hardware/features/shop/models/category_model.dart';
import 'package:magic_hardware/features/shop/screens/all_products/all_products.dart';
import 'package:magic_hardware/features/shop/screens/store/widgets/category_brands.dart';

import '../../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';

/// A widget that displays a tab for a specific category, including its brands and products.
///
/// This widget is designed to be used within a tabbed view, where each tab represents a different category.
/// It displays a list of brands associated with the category and a grid of products from that category.
class MagicCategoryTab extends StatelessWidget {
  /// Creates a [MagicCategoryTab].
  ///
  /// The [category] parameter is required.
  const MagicCategoryTab({super.key, required this.category});

  /// The category to display in the tab.
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(MagicSizes.defaultSpace),
          child: Column(
            children: [
              // Brands
              CategoryBrands(category: category),
              const SizedBox(height: MagicSizes.spaceBtwItems),

              // Products
              FutureBuilder(
                future: controller.getCategoryProducts(categoryId: category.id),
                builder: (context, snapshot) {
                  final widget =
                      MagicCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: const MagicVerticalProductShimmer(),
                      );
                  if (widget != null) return widget;

                  final products = snapshot.data!;

                  return Column(
                    children: [
                      MagicSectionHeading(
                        title: 'You might like',
                        onPressed: () => Get.to(
                          () => AllProductsScreen(
                            title: category.name,
                            futureMethod: controller.getCategoryProducts(
                              categoryId: category.id,
                              limit: -1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: MagicSizes.spaceBtwItems),
                      MagicGridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) =>
                            MagicProductCardVertical(product: products[index]),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
