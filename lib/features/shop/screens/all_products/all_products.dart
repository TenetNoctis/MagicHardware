import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/products/sortable/sortable_products.dart';
import '../../controllers/product/all_products_controller.dart';
import '../../models/product_model.dart';

/// A screen that displays all products.
class AllProductsScreen extends StatelessWidget {
  /// Creates a new [AllProductsScreen] widget.
  const AllProductsScreen({
    super.key,
    required this.title,
    this.query,
    this.futureMethod,
  });

  /// The title of the screen.
  final String title;

  /// The Firestore query used to fetch products.
  final Query? query;

  /// The future method used to fetch products.
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AllProductsController>();

    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        appBar: MagicAppBar(title: Text(title), showBackArrow: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(MagicSizes.defaultSpace),
            child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductsByQuery(query),
              builder: (context, snapshot) {
                const loader = MagicVerticalProductShimmer();
                final widget = MagicCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loader,
                );

                if (widget != null) return widget;

                final products = snapshot.data!;

                return MagicSortableProducts(products: products);
              },
            ),
          ),
        ),
      ),
    );
  }
}
