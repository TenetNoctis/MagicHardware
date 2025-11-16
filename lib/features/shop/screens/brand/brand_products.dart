import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/common/widgets/brands/brand_card.dart';
import 'package:magic_hardware/common/widgets/products/sortable/sortable_products.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../models/brand_model.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MagicAppBar(title: Text('Vaultex'), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MagicSizes.defaultSpace),
          child: Column(
            children: [
              // Brand Detail
              MagicBrandCard(
                brand: BrandModel(
                  id: '1',
                  image: MagicImages.weldingIcon,
                  name: 'Vaultex',
                  productsCount: 256,
                ),
                showBorder: true,
              ),
              SizedBox(height: MagicSizes.spaceBtwSections),

              MagicSortableProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
