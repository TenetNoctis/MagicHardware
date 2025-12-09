import 'package:flutter/material.dart';
import 'package:magic_hardware/utils/device/device_utility.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';

/// A custom TabBar widget that implements [PreferredSizeWidget] to be used in an [AppBar].
class MagicTabBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a [MagicTabBar].
  ///
  /// - [tabs]: A list of widgets to display as tabs.
  const MagicTabBar({super.key, required this.tabs});

  /// The list of tabs to display.
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

  /// Specifies the height of the tab bar.
  /// This is required by the [PreferredSizeWidget] interface.
  @override
  Size get preferredSize => Size.fromHeight(MagicDeviceUtils.getAppBarHeight());
}
