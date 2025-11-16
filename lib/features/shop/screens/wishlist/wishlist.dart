import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/common/widgets/icons/magic_circular_icon.dart';
import 'package:magic_hardware/common/widgets/layouts/grid_layout.dart';
import 'package:magic_hardware/features/shop/screens/home/home.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../models/product_model.dart';


class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => Get.to(NavigationBar(destinations: [HomeScreen()])),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MagicSizes.defaultSpace),
          child: Column(
            children: [
              MagicGridLayout(
                itemCount: 8,
                itemBuilder: (_, index) => MagicProductCardVertical(product: ProductModel.empty()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
