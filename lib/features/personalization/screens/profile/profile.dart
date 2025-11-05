import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/common/widgets/images/magic_circular_image.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:magic_hardware/utils/constants/image_strings.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MagicAppBar(showBackArrow: true, title: Text('Profile')),
      // Body
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MagicSizes.defaultSpace),
        child: Column(
          children: [
            // Profile Picture
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  MagicCircularImage(
                    image: MagicImages.user,
                    width: 80,
                    height: 80,
                  ),
                  TextButton(
                    onPressed: () {},
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
            const MagicSectionHeading(title: 'Profile Information', showActionButton: false),
            const SizedBox(height: MagicSizes.spaceBtwItems),

            MagicProfileMenu(title: 'Name', value: 'Magic Hardware', onPressed: (){}),
            MagicProfileMenu(title: 'Username', value: 'magic_hardware', onPressed: (){}),

            const SizedBox(height: MagicSizes.spaceBtwItems),
            const Divider(),
            const SizedBox(height: MagicSizes.spaceBtwItems),

            // Personal Info
            const MagicSectionHeading(title: 'Personal Information', showActionButton: false),
            const SizedBox(height: MagicSizes.spaceBtwItems),

            MagicProfileMenu(title: 'User ID', icon: Iconsax.copy, value: '132445', onPressed: (){}),
            MagicProfileMenu(title: 'E-mail', value: 'magichardware1@gmail.com', onPressed: (){}),
            MagicProfileMenu(title: 'Phone Number', value: '+960 979-8043', onPressed: (){}),
            MagicProfileMenu(title: 'Gender', value: 'Male', onPressed: (){}),
            MagicProfileMenu(title: 'Date of Birth', value: '26 Sept, 1999', onPressed: (){}),
            
            const Divider(),
            const SizedBox(height: MagicSizes.spaceBtwItems),
            
            Center(
              child: TextButton(onPressed: (){}, child: const Text('Delete Account', style: TextStyle(color: Colors.red),)),
            )
          ],
        ),
      ),
    );
  }
}


