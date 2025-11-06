import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/images/magic_circular_image.dart';
import 'package:magic_hardware/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:magic_hardware/common/widgets/texts/product_price_text.dart';
import 'package:magic_hardware/common/widgets/texts/product_title_text.dart';
import 'package:magic_hardware/utils/constants/enums.dart';
import 'package:magic_hardware/utils/constants/image_strings.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class MagicProductMetaData extends StatelessWidget {
  const MagicProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price & Sale Price
        Row(
          children: [
            // Sale Tag
            MagicRoundedContainer(
              radius: MagicSizes.sm,
              backgroundColor: MagicColors.secondary.withValues(alpha: 0.8),
              padding: EdgeInsets.symmetric(
                horizontal: MagicSizes.xs,
                vertical: MagicSizes.xs,
              ),
              child: Text(
                '-25%',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.apply(color: MagicColors.black),
              ),
            ),
            const SizedBox(width: MagicSizes.spaceBtwItems),

            // Price
            MagicProductPriceText(price: '95', lineThrough: true),
            const SizedBox(width: MagicSizes.spaceBtwItems),
            MagicProductPriceText(price: '71.25', isLarge: true),
          ],
        ),
        const SizedBox(height: MagicSizes.spaceBtwItems / 1.5),

        // Title
        MagicProductTitleText(title: 'Welding Gloves'),

        const SizedBox(height: MagicSizes.spaceBtwItems / 1.5),

        // Stock Status
        Row(
          children: [
            MagicProductTitleText(title: 'Status'),
            const SizedBox(width: MagicSizes.spaceBtwItems),
            Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),

        const SizedBox(height: MagicSizes.spaceBtwItems / 1.5),

        // Brand
        Row(
          children: [
            MagicCircularImage(
              width: 32,
              height: 32,
              overlayColor: dark ? MagicColors.white : MagicColors.black,
              image: MagicImages.weldingIcon,
            ),
            Expanded(
              child: MagicBrandTitleWithVerifiedIcon(
                title: 'Vaultex',
                brandTextSize: TextSizes.medium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
