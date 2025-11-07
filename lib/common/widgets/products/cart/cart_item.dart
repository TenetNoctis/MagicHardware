import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/magic_rounded_image.dart';
import '../../texts/brand_title_text_with_verified_icon.dart';
import '../../texts/product_title_text.dart';

class MagicCartItem extends StatelessWidget {
  const MagicCartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Image
        MagicRoundedImage(
          imageUrl: MagicImages.weldingGlove,
          width: 60,
          height: 60,
          padding: EdgeInsets.all(MagicSizes.sm),
          backgroundColor: MagicHelperFunctions.isDarkMode(context)
              ? MagicColors.darkerGrey
              : MagicColors.light,
        ),
        const SizedBox(width: MagicSizes.spaceBtwItems),

        // Product Name, Price and Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MagicBrandTitleWithVerifiedIcon(title: 'Vaultex'),
              MagicProductTitleText(title: 'Welding Gloves', maxLines: 1),
              // Attributes
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Color ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: 'Green ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: 'Size ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: 'Large ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}