import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/common/widgets/icons/magic_circular_icon.dart';
import 'package:magic_hardware/common/widgets/layouts/grid_layout.dart';
import 'package:magic_hardware/common/widgets/loaders/animation_loader.dart';
import 'package:magic_hardware/features/shop/controllers/product/favorites_controller.dart';
import 'package:magic_hardware/features/shop/controllers/product/product_controller.dart';
import 'package:magic_hardware/features/shop/screens/all_products/all_products.dart';
import 'package:magic_hardware/features/shop/screens/home/home.dart';
import 'package:magic_hardware/utils/constants/image_strings.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavoritesController.instance;
    return Scaffold(
      appBar: MagicAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          MagicCircularIcon(
            backgroundColor: Colors.transparent,
            icon: Iconsax.add,
            onPressed: () =>
                Get.to(NavigationBar(destinations: [HomeScreen()])),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MagicSizes.defaultSpace),
          child: Column(
            children: [
              Obx(() => FutureBuilder(
                  future: controller.favoriteProducts(),
                  builder: (context, snapshot) {
                    // Nothing Found Widget
                    final emptyWidget = Column(
                      children: [
                        SizedBox(height: MagicSizes.spaceBtwSections * 5),
                        MagicAnimationLoaderWidget(
                          text: 'Whoops! Wishlist is empty...',
                          showAction: true,
                          actionText: 'Explore Products',
                          animation: MagicImages.emptyAnimation,
                          width: 0.5,
                          onActionPressed: () =>
                              Get.to(() => AllProductsScreen(title: 'All Products', futureMethod: Get.find<ProductController>().fetchAllFeaturedProducts())),
                        ),
                      ],
                    );
                    final widget =
                        MagicCloudHelperFunctions.checkMultiRecordState(
                          snapshot: snapshot,
                          nothingFound: emptyWidget,
                        );
                    if (widget != null) return widget;

                    final products = snapshot.data!;
                    return MagicGridLayout(
                      itemCount: products.length,
                      itemBuilder: (_, index) =>
                          MagicProductCardVertical(product: products[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
