import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:magic_hardware/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/features/personalization/screens/address/address.dart';
import 'package:magic_hardware/features/shop/screens/cart/cart.dart';
import 'package:magic_hardware/features/shop/screens/order/order.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/products/product_dummy_data.dart';
import '../../../../data/repositories/products/product_repository.dart';
import '../../controllers/user_controller.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    final controller = UserController.instance;
    final admin = '!0SBr5d6jy1VcFXpGV6Vn1b2Cz153';

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            MagicPrimaryHeaderContainer(
              child: Column(
                children: [
                  // AppBar
                  MagicAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium!.apply(color: Colors.white),
                    ),
                  ),

                  // User Profile
                  MagicUserProfileTile(
                    onPressed: () => Get.to(() => const ProfileScreen()),
                  ),
                  const SizedBox(height: MagicSizes.spaceBtwSections),
                ],
              ),
            ),
            // Body
            Padding(
              padding: const EdgeInsets.all(MagicSizes.defaultSpace),
              child: Column(
                children: [
                  // Account Settings
                  MagicSectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),

                  SizedBox(height: MagicSizes.spaceBtwItems),
                  MagicSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set shopping delivery address',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),

                  MagicSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle: 'Add, remove products and move to checkout',
                    onTap: () => Get.to(() => const CartScreen()),
                  ),

                  MagicSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-progress and completed orders',
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),

                  MagicSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Payment Methods',
                    subtitle: 'Add, remove and update payment methods',
                    onTap: () {},
                  ),

                  MagicSettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subtitle: 'List of all coupons',
                    onTap: () {},
                  ),

                  MagicSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subtitle: 'Set notifications',
                    onTap: () {},
                  ),

                  MagicSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subtitle: 'Manage data usage and connected accounts',
                    onTap: () {},
                  ),

                  // App Settings
                  SizedBox(height: MagicSizes.spaceBtwSections),

                  MagicSectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),

                  SizedBox(height: MagicSizes.spaceBtwItems),

                  if (controller.user.value!.id == admin)
                    MagicSettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: 'Load Data',
                      subtitle: 'Upload Data to your Cloud Firebase',
                      onTap: () {
                        final productRepository = Get.put(ProductRepository());
                        productRepository.uploadDummyData(
                          MagicDummyData.products,
                        );
                      },
                    ),

                  MagicSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subtitle: 'Set recommendations based on location',
                    onTap: () {},
                    trailing: Switch(
                      value: true,
                      activeTrackColor: MagicColors.primary,
                      activeThumbColor: dark
                          ? MagicColors.black
                          : MagicColors.white,
                      onChanged: (value) {},
                    ),
                  ),

                  MagicSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subtitle: 'Search results are safe for all ages',
                    onTap: () {},
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  MagicSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subtitle: 'Set image quality to maximum',
                    onTap: () {},
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  // Logout Button
                  const SizedBox(height: MagicSizes.spaceBtwSections),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: MagicColors.primary),
                      ),
                      onPressed: () =>
                          AuthenticationRepository.instance.logout(),
                      child: const Text('Logout'),
                    ),
                  ),

                  const SizedBox(height: MagicSizes.spaceBtwSections * 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
