import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/features/personalization/controllers/user_controller.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/magic_circular_image.dart';

class MagicUserProfileTile extends StatelessWidget {
  const MagicUserProfileTile({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Obx(() => ListTile(

        leading: MagicCircularImage(
          image: MagicImages.user,
          width: 50,
          height: 50,
          padding: 0,
        ),

        title: Text(
          controller.user.value!.fullName,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.apply(color: MagicColors.white),
        ),

        subtitle: Text(
          controller.user.value!.email,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.apply(color: MagicColors.white),
        ),

        trailing: IconButton(
          onPressed: onPressed,
          icon: Icon(Iconsax.edit, color: MagicColors.white),
        ),
      ),
    );
  }
}
