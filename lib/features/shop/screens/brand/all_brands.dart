import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/common/widgets/brands/brand_card.dart';
import 'package:magic_hardware/common/widgets/layouts/grid_layout.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/features/shop/screens/brand/brand_products.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../models/brand_model.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MagicAppBar(title: Text('All Brands'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MagicSizes.defaultSpace),
          child: Column(
            children: [
              // Title
              MagicSectionHeading(title: 'Brands', showActionButton: false),
              SizedBox(height: MagicSizes.spaceBtwItems),

              // Brands
              MagicGridLayout(
                mainAxisExtent: 80,
                itemCount: 10,
                itemBuilder: (context, _) => MagicBrandCard(
                  showBorder: true,
                  brand: BrandModel(
                    image: MagicImages.weldingIcon,
                    name: 'Vaultex',
                    productsCount: 256,
                  ),
                  onTap: () => Get.to(() => BrandProducts()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
