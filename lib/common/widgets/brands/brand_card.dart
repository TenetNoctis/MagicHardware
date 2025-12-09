import 'package:flutter/material.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../images/magic_circular_image.dart';
import '../texts/brand_title_text_with_verified_icon.dart';

/// A card widget that displays brand information.
class MagicBrandCard extends StatelessWidget {
  /// Creates a [MagicBrandCard].
  ///
  /// - [brand]: The brand data to display.
  /// - [showBorder]: Whether to show a border around the card.
  /// - [onTap]: A callback function to be executed when the card is tapped.
  const MagicBrandCard({
    super.key,
    required this.brand,
    required this.showBorder,
    this.onTap,
  });

  /// The brand data to display.
  final BrandModel brand;

  /// Whether to show a border around the card.
  final bool showBorder;

  /// A callback function to be executed when the card is tapped.
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = MagicHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      // Main container for the brand card.
      child: MagicRoundedContainer(
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(MagicSizes.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Brand icon/image.
            Flexible(
              child: MagicCircularImage(
                fit: BoxFit.contain,
                radius: 0,
                image: brand.image,
                isNetworkImage: true,
                backgroundColor: Colors.transparent,
                overlayColor: isDark ? MagicColors.white : MagicColors.black,
              ),
            ),
            const SizedBox(width: MagicSizes.spaceBtwItems / 2),

            // Brand name and product count.
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MagicBrandTitleWithVerifiedIcon(
                    title: brand.name,
                    brandTextSize: TextSizes.medium,
                  ),
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
