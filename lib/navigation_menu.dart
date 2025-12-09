import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import 'features/personalization/screens/settings/settings.dart';
import 'features/shop/screens/home/home.dart';
import 'features/shop/screens/store/store.dart';
import 'features/shop/screens/wishlist/wishlist.dart';

/// The main navigation menu of the application.
///
/// This widget displays a bottom navigation bar with four destinations:
/// Home, Shop, Wishlist, and Profile. The body of the scaffold displays
/// the corresponding screen based on the selected destination.
class NavigationMenu extends StatelessWidget {
  /// Creates a [NavigationMenu] widget.
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = MagicHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? MagicColors.darkestGrey : Colors.white,
          indicatorColor: darkMode
              ? MagicColors.white.withValues(alpha: 0.1)
              : MagicColors.black.withValues(alpha: 0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Shop'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

/// A controller for the [NavigationMenu].
///
/// This class manages the state of the navigation menu, including the
/// currently selected index and the list of screens to display.
class NavigationController extends GetxController {
  /// The observable integer representing the currently selected index in the
  /// navigation bar.
  final Rx<int> selectedIndex = 0.obs;

  /// The list of screens to be displayed in the body of the [NavigationMenu].
  ///
  /// The order of the screens corresponds to the order of the destinations
  /// in the navigation bar.
  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const WishlistScreen(),
    const SettingsScreen(),
  ];
}
