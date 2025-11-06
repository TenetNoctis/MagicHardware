import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/icons/magic_circular_icon.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

class MagicBottomAddToCart extends StatelessWidget {
  const MagicBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MagicSizes.defaultSpace,
        vertical: MagicSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? MagicColors.darkerGrey : MagicColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MagicSizes.borderRadiusLg),
          topRight: Radius.circular(MagicSizes.borderRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const MagicCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: MagicColors.darkGrey,
                width: 40,
                height: 40,
                color: MagicColors.white,
              ),
              const SizedBox(width: MagicSizes.spaceBtwItems),
              Text('2', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: MagicSizes.spaceBtwItems),
              MagicCircularIcon(
                icon: Iconsax.add,
                backgroundColor: MagicColors.black,
                width: 40,
                height: 40,
                color: MagicColors.white,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(MagicSizes.md),
              backgroundColor: MagicColors.black,
              side: const BorderSide(color: MagicColors.black),
            ),
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
