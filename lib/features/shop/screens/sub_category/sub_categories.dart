import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/common/widgets/images/magic_rounded_image.dart';
import 'package:magic_hardware/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/features/shop/controllers/category_controller.dart';
import 'package:magic_hardware/features/shop/screens/all_products/all_products.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

import '../../../../common/widgets/shimmers/horizontal_product_shimmer.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../models/category_model.dart';

/// A screen that displays the sub-categories for a given category.
///
/// This screen shows a banner image (if available) for the main category,
/// followed by a list of its sub-categories. For each sub-category, it displays
/// a heading and a horizontal list of its products.
class SubCategoriesScreen extends StatelessWidget {
  /// Creates a [SubCategoriesScreen].
  ///
  /// The [category] parameter is required and represents the parent category
  /// for which to display the sub-categories.
  const SubCategoriesScreen({super.key, required this.category});

  /// The parent category.
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: MagicAppBar(title: Text(category.name), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MagicSizes.defaultSpace),
          child: Column(
            children: [
              // Banner - Only show if bannerImage is not null
              if (category.bannerImage != null &&
                  category.bannerImage!.isNotEmpty) ...[
                MagicRoundedImage(
                  imageUrl: category.bannerImage!,
                  isNetworkImage: true,
                  width: double.infinity,
                  applyImageRadius: true,
                ),
                SizedBox(height: MagicSizes.spaceBtwSections),
              ],

              // Sub-Categories
              FutureBuilder(
                future: controller.getSubCategories(category.id),
                builder: (context, snapshot) {
                  const loader = MagicHorizontalProductShimmer();
                  final widget =
                      MagicCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: loader,
                      );
                  if (widget != null) return widget;
                  final subCategories = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: subCategories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final subCategory = subCategories[index];
                      return FutureBuilder(
                        future: controller.getCategoryProducts(
                          categoryId: subCategory.id,
                        ),
                        builder: (context, snapshot) {
                          final widget =
                              MagicCloudHelperFunctions.checkMultiRecordState(
                                snapshot: snapshot,
                                loader: loader,
                              );
                          if (widget != null) return widget;
                          final products = snapshot.data!;
                          return Column(
                            children: [
                              // Heading
                              MagicSectionHeading(
                                title: subCategory.name,
                                onPressed: () => Get.to(
                                  () => AllProductsScreen(
                                    title: subCategory.name,
                                    futureMethod: controller
                                        .getCategoryProducts(
                                          categoryId: subCategory.id,
                                          limit: -1,
                                        ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: MagicSizes.spaceBtwItems / 2,
                              ),

                              SizedBox(
                                height: 120,
                                child: ListView.separated(
                                  itemCount: products.length,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        width: MagicSizes.spaceBtwItems,
                                      ),
                                  itemBuilder: (context, index) =>
                                      MagicProductCardHorizontal(
                                        product: products[index],
                                      ),
                                ),
                              ),
                              const SizedBox(
                                height: MagicSizes.spaceBtwSections / 2,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
