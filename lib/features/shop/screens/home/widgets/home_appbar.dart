import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/features/personalization/controllers/user_controller.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';

class MagicHomeAppBar extends StatelessWidget {
  const MagicHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
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
          const SizedBox(height: 5),
          Obx(() {
            if (controller.profileLoading.value) {
              return const MagicShimmerEffect(width: 80, height: 15);
            } else {
              return Text(
                controller.user.value!.fullName,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.apply(color: MagicColors.white),
              );
            }
          }),
        ],
      ),
      actions: [
        MagicCartCounterIcon(iconColor: MagicColors.white, counterBgColor: MagicColors.white, counterTextColor: MagicColors.black),
      ],
    );
  }
}
