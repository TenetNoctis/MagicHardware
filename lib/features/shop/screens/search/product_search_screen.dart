import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/common/widgets/layouts/grid_layout.dart';
import 'package:magic_hardware/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:magic_hardware/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:magic_hardware/features/shop/controllers/product/product_search_controller.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class ProductSearchScreen extends StatelessWidget {
  const ProductSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductSearchController());
    final searchController = TextEditingController();

    return Scaffold(
      appBar: MagicAppBar(
        showBackArrow: true,
        title: Text('Search Products'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(MagicSizes.defaultSpace),
            child: TextField(
              controller: searchController,
              autofocus: true,
              onChanged: (value) => controller.searchProducts(value),
              decoration: InputDecoration(
                hintText: 'Search for products...',
                prefixIcon: const Icon(Iconsax.search_normal),
                suffixIcon: Obx(() {
                  return controller.searchQuery.value.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Iconsax.close_circle),
                    onPressed: () {
                      searchController.clear();
                      controller.clearSearch();
                    },
                  )
                      : const SizedBox.shrink();
                }),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(MagicSizes.cardRadiusLg),
                ),
              ),
            ),
          ),

          // Search Results
          Expanded(
            child: Obx(() {
              // Loading state
              if (controller.isLoading.value) {
                return const MagicVerticalProductShimmer();
              }

              // No search query entered
              if (!controller.isSearching.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.search_normal,
                        size: 80,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: MagicSizes.spaceBtwItems),
                      Text(
                        'Search for products',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: MagicSizes.sm),
                      Text(
                        'Enter a product name, brand, or category',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              // No results found
              if (controller.searchResults.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.search_status,
                        size: 80,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: MagicSizes.spaceBtwItems),
                      Text(
                        'No products found',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: MagicSizes.sm),
                      Text(
                        'Try searching with different keywords',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );
              }

              // Display search results
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(MagicSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${controller.searchResults.length} results found',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: MagicSizes.spaceBtwItems),
                      MagicGridLayout(
                        itemCount: controller.searchResults.length,
                        itemBuilder: (_, index) => MagicProductCardVertical(
                          product: controller.searchResults[index],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}