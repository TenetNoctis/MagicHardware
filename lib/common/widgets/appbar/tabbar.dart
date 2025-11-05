import 'package:flutter/material.dart';
import 'package:magic_hardware/utils/device/device_utility.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';

class MagicTabBar extends StatelessWidget implements PreferredSizeWidget {
  const MagicTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? MagicColors.black : MagicColors.white,
      child: TabBar(
        tabAlignment: TabAlignment.start,
        tabs: tabs,
        isScrollable: true,
        indicatorColor: MagicColors.primary,
        labelColor: dark ? MagicColors.white : MagicColors.primary,
        unselectedLabelColor: MagicColors.darkGrey,
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(MagicDeviceUtils.getAppBarHeight());
}

