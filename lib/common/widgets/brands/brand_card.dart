import 'package:flutter/material.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/magic_circular_image.dart';
import '../texts/brand_title_text_with_verified_icon.dart';



class MagicBrandCard extends StatelessWidget {
  const MagicBrandCard({
    super.key,
    required this.brand,
    required this.showBorder,
    this.onTap,
  });

  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = MagicHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      /// Container Design
      child: MagicRoundedContainer(
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(MagicSizes.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// -- Icon
            Flexible(
              child: MagicCircularImage(
                image: brand.image,
                isNetworkImage: false,
                backgroundColor: Colors.transparent,
                overlayColor: isDark ? MagicColors.white : MagicColors.black,
              ),
            ),
            const SizedBox(width: MagicSizes.spaceBtwItems / 2),

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MagicBrandTitleWithVerifiedIcon(title: brand.name, brandTextSize: TextSizes.large),
                  Text(
                    '${brand.productsCount ?? 0} products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}