import 'package:flutter/material.dart';
import 'package:magic_hardware/features/shop/models/cart_item_model.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/magic_rounded_image.dart';
import '../../texts/brand_title_text_with_verified_icon.dart';
import '../../texts/product_title_text.dart';

class MagicCartItem extends StatelessWidget {
  const MagicCartItem(
      {super.key, required this.cartItem, this.showQuantity = false});

  final CartItemModel cartItem;
  final bool showQuantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Image
        MagicRoundedImage(
          imageUrl: cartItem.image ?? '',
          isNetworkImage: true,
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
              MagicBrandTitleWithVerifiedIcon(title: cartItem.brandName ?? ''),
              MagicProductTitleText(title: cartItem.title, maxLines: 1),
              // Attributes
              Text.rich(
                TextSpan(
                  children: (cartItem.selectedVariation ?? {}).entries.map(
                        (e) =>
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${e.key} ',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodySmall,
                            ),
                            TextSpan(
                              text: '${e.value} ',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyLarge,
                            ),
                          ],
                        ),
                  ).toList(),
                ),
              ),
              if (showQuantity) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Qty: ${cartItem.quantity}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text('MVR ${cartItem.price.toStringAsFixed(2)}')
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
