import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/utils/device/device_utility.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

/// A custom app bar widget that implements [PreferredSizeWidget] to be used in an [AppBar].
class MagicAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a [MagicAppBar].
  ///
  /// - [title]: The title widget displayed in the app bar.
  /// - [showBackArrow]: Whether to show a back arrow button.
  /// - [leadingIcon]: An optional icon to display as the leading widget.
  /// - [actions]: A list of widgets to display as actions.
  /// - [leadingOnPressed]: The callback for the leading icon.
  const MagicAppBar({
    super.key,
    this.title,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.showBackArrow = false,
  });

  /// The title widget of the app bar.
  final Widget? title;

  /// Whether to display a back arrow.
  final bool showBackArrow;

  /// The leading icon for the app bar.
  final IconData? leadingIcon;

  /// A list of action widgets to be displayed in the app bar.
  final List<Widget>? actions;

  /// The callback that is called when the leading icon is tapped.
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Get.back(closeOverlays: true),
                icon: const Icon(Iconsax.arrow_left),
                color: dark ? Colors.white : Colors.black,
              )
            : leadingIcon != null
            ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon))
            : null,
        title: title,
        actions: actions,
      ),
    );
  }

  /// Specifies the height of the app bar.
  /// This is required by the [PreferredSizeWidget] interface.
  @override
  Size get preferredSize => Size.fromHeight(MagicDeviceUtils.getAppBarHeight());
}
