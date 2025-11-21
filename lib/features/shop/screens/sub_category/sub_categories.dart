import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/common/widgets/images/magic_rounded_image.dart';
import 'package:magic_hardware/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/features/shop/controllers/category_controller.dart';
import 'package:magic_hardware/features/shop/screens/all_products/all_products.dart';
import 'package:magic_hardware/utils/constants/image_strings.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

import '../../../../common/widgets/shimmers/horizontal_product_shimmer.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../models/category_model.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

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
              // Banner
              MagicRoundedImage(
                imageUrl: MagicImages.promoBanner2,
                width: double.infinity,
                applyImageRadius: true,
              ),
              SizedBox(height: MagicSizes.spaceBtwSections),

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
                                      MagicProductCardHorizontal(product: products[index]),
                                ),
                              ),
                              const SizedBox(height: MagicSizes.spaceBtwSections / 2),
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
