import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../custom_shapes/containers/rounded_container.dart';

/// A widget that provides a text field for entering a coupon code and a button to apply it.
class MagicCouponCode extends StatelessWidget {
  /// Creates a [MagicCouponCode] widget.
  const MagicCouponCode({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return MagicRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? MagicColors.dark : MagicColors.white,
      padding: const EdgeInsets.only(
        top: MagicSizes.sm,
        bottom: MagicSizes.sm,
        right: MagicSizes.sm,
        left: MagicSizes.md,
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a promo code? Enter Here!',
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),

          // Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: dark
                    ? MagicColors.white.withValues(alpha: 0.5)
                    : MagicColors.dark.withValues(alpha: 0.5),
                backgroundColor: MagicColors.darkerGrey.withValues(alpha: 0.5),
                side: BorderSide(
                  color: MagicColors.grey.withValues(alpha: 0.1),
                ),
              ),
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }
}
