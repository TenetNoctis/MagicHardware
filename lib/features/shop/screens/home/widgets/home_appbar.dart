import 'package:flutter/material.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';

class MagicHomeAppBar extends StatelessWidget {
  const MagicHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MagicAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            MagicTexts.homeAppbarTitle,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: MagicColors.grey),
          ),
          Text(
            MagicTexts.homeAppbarSubTitle,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: MagicColors.white),
          ),
        ],
      ),
      actions: [
        MagicCartCounterIcon(onPressed: () {}, iconColor: MagicColors.white),
      ],
    );
  }
}
