import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

import '../../../../common/widgets/products/sortable/sortable_products.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MagicAppBar(title: Text('Popular Products'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MagicSizes.defaultSpace),
          child: MagicSortableProducts(),
        ),
      ),
    );
  }
}

