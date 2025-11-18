import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/images/magic_circular_image.dart';
import 'package:magic_hardware/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:magic_hardware/common/widgets/texts/product_price_text.dart';
import 'package:magic_hardware/common/widgets/texts/product_title_text.dart';
import 'package:magic_hardware/features/shop/controllers/product/product_controller.dart';
import 'package:magic_hardware/features/shop/models/product_model.dart';
import 'package:magic_hardware/utils/constants/enums.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class MagicProductMetaData extends StatelessWidget {
  const MagicProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(
      product.price,
      product.salePrice,
    );
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price & Sale Price
        Row(
          children: [
            // Sale Tag
            if (salePercentage != null && double.parse(salePercentage) > 0) ...[
              MagicRoundedContainer(
                radius: MagicSizes.sm,
                backgroundColor: MagicColors.secondary.withValues(alpha: 0.8),
                padding: EdgeInsets.symmetric(
                  horizontal: MagicSizes.xs,
                  vertical: MagicSizes.xs,
                ),
                child: Text(
                  '$salePercentage%',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.apply(color: MagicColors.black),
                ),
              ),
              const SizedBox(width: MagicSizes.spaceBtwItems),

              // Price
              MagicProductPriceText(
                price: '${product.price}',
                lineThrough: true,
              ),
              const SizedBox(width: MagicSizes.spaceBtwItems),
            ],
            MagicProductPriceText(
              price: controller.getProductPrice(product),
              isLarge: true,
            ),
          ],
        ),
        const SizedBox(height: MagicSizes.spaceBtwItems / 1.5),

        // Title
        MagicProductTitleText(title: product.title),

        const SizedBox(height: MagicSizes.spaceBtwItems / 1.5),

        // Stock Status
        Row(
          children: [
            MagicProductTitleText(title: 'Status:'),
            const SizedBox(width: MagicSizes.spaceBtwItems),
            Text(
              controller.getProductStockStatus(product.stock),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),

        const SizedBox(height: MagicSizes.spaceBtwItems / 1.5),

        // Brand
        if (product.brand != null)
          Row(
            children: [
              MagicCircularImage(
                fit: BoxFit.contain,
                width: 50,
                height: 50,
                radius: 0,
                overlayColor: dark ? MagicColors.white : MagicColors.black,
                isNetworkImage: true,
                image: product.brand!.image,
              ),
              Expanded(
                child: MagicBrandTitleWithVerifiedIcon(
                  title: product.brand!.name,
                  brandTextSize: TextSizes.medium,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
