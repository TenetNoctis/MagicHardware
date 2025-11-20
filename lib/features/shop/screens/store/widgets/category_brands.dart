import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/brands/brand_showcase.dart';
import 'package:magic_hardware/features/shop/controllers/brand_controller.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

import '../../../../../common/widgets/shimmers/boxes_shimmer.dart';
import '../../../../../common/widgets/shimmers/list_tile_shimmer.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../models/category_model.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandsForCategory(category.id),
      builder: (context, snapshot) {
        // Loader
        const loader = Column(
          children: [
            MagicListTileShimmer(),
            SizedBox(height: MagicSizes.spaceBtwItems),
            MagicBoxesShimmer(),
            SizedBox(height: MagicSizes.spaceBtwItems),
          ],
        );
        final widget = MagicCloudHelperFunctions.checkMultiRecordState(
          snapshot: snapshot,
          loader: loader,
        );
        if (widget != null) return widget;

        final brands = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (_, index) {
            final brand = brands[index];
            return FutureBuilder(
              future: controller.getBrandProducts(brandId: brand.id),
              builder: (context, snapshot) {
                final widget = MagicCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loader,
                );
                if (widget != null) return widget;
                final products = snapshot.data!;
                return MagicBrandShowcase(
                  brand: brand,
                  images: products.map((e) => e.thumbnail).toList(),
                );
              },
            );
          },
        );
      },
    );
  }
}
