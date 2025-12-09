import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/features/personalization/controllers/user_controller.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/magic_circular_image.dart';

/// A user profile tile widget that displays user information.
///
/// This widget shows the user's profile picture, full name, and email.
/// It also includes an edit button to allow for modifications.
class MagicUserProfileTile extends StatelessWidget {
  /// Creates a user profile tile.
  ///
  /// The [onPressed] callback is triggered when the edit button is tapped.
  const MagicUserProfileTile({super.key, this.onPressed});

  /// A callback function to be executed when the edit button is pressed.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Obx(() {
      final networkImage = controller.user.value!.profilePicture;
      final image = networkImage.isNotEmpty ? networkImage : MagicImages.user;

      return ListTile(
        leading: MagicCircularImage(
          image: image,
          width: 50,
          height: 50,
          padding: 0,
          isNetworkImage: networkImage.isNotEmpty,
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
          icon: const Icon(Iconsax.edit, color: MagicColors.white),
        ),
      );
    });
  }
}
