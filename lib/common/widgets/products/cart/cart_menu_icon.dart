import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';

class MagicCartCounterIcon extends StatelessWidget {
  const MagicCartCounterIcon({
    super.key,
    required this.onPressed,
    this.iconColor,
    this.textColor,
  });

  final Color? iconColor;
  final Color? textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {

    final dark = MagicHelperFunctions.isDarkMode(context);

    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(Iconsax.shopping_bag),
          color: iconColor ?? (dark ? MagicColors.white : MagicColors.black),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: iconColor ?? (dark ? MagicColors.white : MagicColors.black),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                '2',
                style: Theme.of(context).textTheme.labelLarge!.apply(
                  color: textColor ?? (dark ? MagicColors.black : MagicColors.white),
                  fontSizeFactor: 0.8,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
