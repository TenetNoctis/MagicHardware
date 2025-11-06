import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:magic_hardware/common/widgets/texts/product_price_text.dart';
import 'package:magic_hardware/common/widgets/texts/product_title_text.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';

class MagicProductAttributes extends StatelessWidget {
  const MagicProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        // Selected Attribute Pricing and Description
        MagicRoundedContainer(
          padding: EdgeInsets.all(MagicSizes.md),
          backgroundColor: dark ? MagicColors.darkerGrey : MagicColors.grey,
          child: Column(
            children: [
              // Title, Price and Stock Status
              Row(
                children: [
                  const MagicSectionHeading(
                    title: 'Variation',
                    showActionButton: false,
                  ),
                  const SizedBox(width: MagicSizes.spaceBtwItems),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const MagicProductTitleText(
                            title: 'Price : ',
                            smallSize: true,
                          ),

                          // Actual Price
                          MagicProductPriceText(price: '95', lineThrough: true),
                          const SizedBox(width: MagicSizes.spaceBtwItems),
                          // Sale Price
                          MagicProductPriceText(price: '71.25'),
                        ],
                      ),

                      Row(
                        children: [
                          const MagicProductTitleText(
                            title: 'Stock : ',
                            smallSize: true,
                          ),
                          Text(
                            'In Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              // Variation Description
              const MagicProductTitleText(
                title:
                    'This is a description of the product. This is a description of the product. This is a description of the product',
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: MagicSizes.spaceBtwItems),

        // Attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MagicSectionHeading(title: 'Colors'),
            Wrap(
              spacing: 8,
              children: [
                MagicChoiceChip(text: 'Green', selected: false, onSelected: (value) {}),
                MagicChoiceChip(text: 'Blue', selected: true, onSelected: (value) {}),
                MagicChoiceChip(text: 'Yellow', selected: false, onSelected: (value) {}),
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MagicSectionHeading(title: 'Size'),
            Wrap(
              spacing: 8,
              children: [
                MagicChoiceChip(text: 'Small', selected: true, onSelected: (value) {}),
                MagicChoiceChip(text: 'Medium', selected: false, onSelected: (value) {}),
                MagicChoiceChip(text: 'Large', selected: false, onSelected: (value) {}),
              ],
            )
          ],
        ),
      ],
    );
  }
}


