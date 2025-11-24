import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../icons/magic_circular_icon.dart';

class MagicProductQuantityWithAddRemoveButton extends StatelessWidget {
  const MagicProductQuantityWithAddRemoveButton({
    super.key,
    required this.quantity,
    this.add,
    this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MagicCircularIcon(
          icon: Iconsax.minus,
          height: 32,
          width: 32,
          size: MagicSizes.md,
          color: MagicHelperFunctions.isDarkMode(context)
              ? MagicColors.white
              : MagicColors.black,
          backgroundColor: MagicHelperFunctions.isDarkMode(context)
              ? MagicColors.darkerGrey
              : MagicColors.light,
          onPressed: remove,
        ),
        const SizedBox(width: MagicSizes.spaceBtwItems),
        Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: MagicSizes.spaceBtwItems),
        MagicCircularIcon(
          icon: Iconsax.add,
          height: 32,
          width: 32,
          size: MagicSizes.md,
          color: MagicColors.white,
          backgroundColor: MagicColors.primary,
          onPressed: add,
        ),
      ],
    );
  }
}
