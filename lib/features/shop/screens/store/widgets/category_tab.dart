import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/layouts/grid_layout.dart';
import 'package:magic_hardware/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/features/shop/models/category_model.dart';

import '../../../../../common/widgets/brands/brand_showcase.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class MagicCategoryTab extends StatelessWidget {
  const MagicCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(MagicSizes.defaultSpace),
          child: Column(
            children: [
              // Brands
              MagicBrandShowcase(
                images: [
                  MagicImages.weldingGlove,
                  MagicImages.weldingGlove,
                  MagicImages.weldingGlove,
                ],
              ),
              const SizedBox(height: MagicSizes.spaceBtwItems),

              // Products
              MagicSectionHeading(title: 'You might like', onPressed: () {}),
              const SizedBox(height: MagicSizes.spaceBtwItems),

              MagicGridLayout(
                itemCount: 4,
                itemBuilder: (_, index) => const MagicProductCardVertical(),
              ),
              const SizedBox(height: MagicSizes.spaceBtwItems),
            ],
          ),
        ),
      ],
    );
  }
}
