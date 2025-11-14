import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/common/widgets/appbar/tabbar.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:magic_hardware/common/widgets/layouts/grid_layout.dart';
import 'package:magic_hardware/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/features/shop/controllers/category_controller.dart';
import 'package:magic_hardware/features/shop/screens/brand/all_brands.dart';
import 'package:magic_hardware/features/shop/screens/store/widgets/category_tab.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/image_strings.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/brands/brand_card.dart';
import '../../models/brand_model.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: MagicAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [MagicCartCounterIcon(onPressed: () {})],
        ),

        body: NestedScrollView(
          // Header
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: MagicHelperFunctions.isDarkMode(context)
                    ? MagicColors.black
                    : MagicColors.white,
                expandedHeight: 440,

                flexibleSpace: Padding(
                  padding: EdgeInsets.all(MagicSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // Search Bar
                      SizedBox(height: MagicSizes.spaceBtwItems),
                      MagicSearchContainer(
                        text: 'Search in Store',
                        showBorder: true,
                        padding: EdgeInsets.zero,
                        // showBackground: false,
                      ),
                      SizedBox(height: MagicSizes.spaceBtwSections),

                      // Featured Brands
                      MagicSectionHeading(
                        title: 'Featured Brands',
                        onPressed: () => Get.to(() => const AllBrandsScreen()),
                      ),
                      const SizedBox(height: MagicSizes.spaceBtwItems / 1.5),

                      // Brand Grid
                      MagicGridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {
                          return MagicBrandCard(
                            showBorder: true,
                            brand: BrandModel(
                              image: MagicImages.weldingIcon,
                              name: 'Vaultex',
                              productsCount: 256,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Tabs
                bottom: MagicTabBar(tabs: categories.map((category) => Tab(child: Text(category.name))).toList()),
              ),
            ];
          },

          // Body
          body: TabBarView(
            children: categories.map((category) => MagicCategoryTab(category: category)).toList()),
        ),
      ),
    );
  }
}

