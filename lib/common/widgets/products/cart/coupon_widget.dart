import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../custom_shapes/containers/rounded_container.dart';

class MagicCouponCode extends StatelessWidget {
  const MagicCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return MagicRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? MagicColors.dark : MagicColors.white,
      padding: EdgeInsets.only(
        top: MagicSizes.sm,
        bottom: MagicSizes.sm,
        right: MagicSizes.sm,
        left: MagicSizes.md,
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
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
                  foregroundColor: dark ? MagicColors.white.withValues(alpha: 0.5) : MagicColors.dark.withValues(alpha: 0.5),
                  backgroundColor: MagicColors.darkerGrey.withValues(alpha: 0.5),
                  side: BorderSide(color: MagicColors.grey.withValues(alpha: 0.1))
              ),
              child: Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }
}
