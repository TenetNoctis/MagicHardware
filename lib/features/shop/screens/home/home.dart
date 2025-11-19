import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/layouts/grid_layout.dart';
import 'package:magic_hardware/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:magic_hardware/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:magic_hardware/features/shop/screens/all_products/all_products.dart';
import 'package:magic_hardware/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:magic_hardware/features/shop/screens/home/widgets/home_categories.dart';
import 'package:magic_hardware/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../controllers/product/all_products_controller.dart';
import '../../controllers/product/product_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    Get.put(AllProductsController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const MagicPrimaryHeaderContainer(
              child: Column(
                children: [
                  //Appbar
                  Padding(
                    padding: EdgeInsets.only(
                      right: MagicSizes.defaultSpace / 2,
                    ),
                    child: MagicHomeAppBar(),
                  ),
                  SizedBox(height: MagicSizes.spaceBtwSections),

                  // Searchbar
                  MagicSearchContainer(text: 'Search in Store'),
                  SizedBox(height: MagicSizes.spaceBtwSections),

                  // Categories
                  Padding(
                    padding: EdgeInsets.only(left: MagicSizes.defaultSpace),
                    child: Column(
                      children: [
                        // Heading
                        MagicSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: MagicColors.white,
                        ),
                        SizedBox(height: MagicSizes.spaceBtwItems),

                        // Categories
                        MagicHomeCategories(),
                      ],
                    ),
                  ),

                  SizedBox(height: MagicSizes.spaceBtwSections),
                ],
              ),
            ),

            // Body

            // Promo Slider
            Padding(
              padding: const EdgeInsets.only(top: MagicSizes.defaultSpace),
              child: const MagicPromoSlider(),
            ),

            Padding(
              padding: const EdgeInsets.all(MagicSizes.defaultSpace),
              child: Column(
                children: [
                  // Heading
                  MagicSectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(
                      () => AllProductsScreen(
                        title: 'Popular Products',
                        futureMethod: controller.fetchAllFeaturedProducts(),
                      ),
                    ),
                  ),
                  const SizedBox(height: MagicSizes.spaceBtwItems),

                  // Popular Products
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const MagicVerticalProductShimmer();
                    }
                    if (controller.featuredProducts.isEmpty) {
                      return Center(
                        child: Text(
                          'No Data Found!',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }
                    return MagicGridLayout(
                      itemCount: controller.featuredProducts.length,
                      itemBuilder: (_, index) => MagicProductCardVertical(
                        product: controller.featuredProducts[index],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
