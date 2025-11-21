import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/common/widgets/images/magic_circular_image.dart';
import 'package:magic_hardware/common/widgets/shimmers/shimmer.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/features/personalization/controllers/user_controller.dart';
import 'package:magic_hardware/features/personalization/screens/profile/widgets/change_dob.dart';
import 'package:magic_hardware/features/personalization/screens/profile/widgets/change_gender.dart';
import 'package:magic_hardware/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:magic_hardware/features/personalization/screens/profile/widgets/change_phone.dart';
import 'package:magic_hardware/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:magic_hardware/utils/constants/image_strings.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

import '../../../../utils/popups/loaders.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: MagicAppBar(showBackArrow: true, title: Text('Profile')),
      // Body
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MagicSizes.defaultSpace),
        child: Obx(
          () => Column(
            children: [
              // Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      if (controller.imageUploading.value) {
                        return const MagicShimmerEffect(
                          width: 60,
                          height: 60,
                          radius: 60,
                        );
                      }
                      final networkImage =
                          controller.user.value!.profilePicture;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : MagicImages.user;
                      return MagicCircularImage(
                        image: image,
                        width: 80,
                        height: 80,
                        isNetworkImage: networkImage.isNotEmpty,
                      );
                    }),
                    TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: const Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),

              // Details
              const SizedBox(height: MagicSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: MagicSizes.spaceBtwItems),

              // Profile Info
              const MagicSectionHeading(
                title: 'Profile Information',
                showActionButton: false,
              ),
              const SizedBox(height: MagicSizes.spaceBtwItems),

              MagicProfileMenu(
                title: 'Name',
                icon: Iconsax.arrow_right_34,
                value: controller.user.value!.fullName,
                onPressed: () => Get.to(() => const ChangeName()),
              ),

              MagicProfileMenu(
                title: 'Username',
                value: controller.user.value!.username,
                onPressed: () {},
              ),

              const SizedBox(height: MagicSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: MagicSizes.spaceBtwItems),

              // Personal Info
              const MagicSectionHeading(
                title: 'Personal Information',
                showActionButton: false,
              ),
              const SizedBox(height: MagicSizes.spaceBtwItems),

              MagicProfileMenu(
                title: 'User ID',
                icon: Iconsax.copy,
                value: controller.user.value!.id,
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(text: controller.user.value!.id),
                  );
                  MagicLoaders.successSnackBar(
                    title: 'Copied',
                    message: 'User ID copied to clipboard',
                  );
                },
              ),

              MagicProfileMenu(
                title: 'E-mail',
                value: controller.user.value!.email,
                onPressed: () {},
              ),

              MagicProfileMenu(
                title: 'Phone Number',
                icon: Iconsax.arrow_right_34,
                value: controller.user.value!.phoneNumber.isEmpty ? 'Not Set' : controller.user.value!.phoneNumber,
                onPressed: () => Get.to(() => const ChangePhone()),
              ),


              MagicProfileMenu(
                title: 'Gender',
                icon: Iconsax.arrow_right_34,
                value: controller.user.value!.gender.isEmpty ? 'Not set' : controller.user.value!.gender,
                onPressed: () => Get.to(() => const ChangeGender()),
              ),
              MagicProfileMenu(
                title: 'Date of Birth',
                icon: Iconsax.arrow_right_34,
                value: controller.user.value!.dateOfBirth.isEmpty ? 'Not set' : controller.user.value!.dateOfBirth,
                onPressed: () => Get.to(() => const ChangeDob()),
              ),

              const Divider(),
              const SizedBox(height: MagicSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
