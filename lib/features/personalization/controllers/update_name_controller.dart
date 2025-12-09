import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/data/repositories/user/user_repository.dart';
import 'package:magic_hardware/features/personalization/controllers/user_controller.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

/// Controller for updating the user's name.
class UpdateNameController extends GetxController {
  /// Provides a singleton instance of the [UpdateNameController].
  static UpdateNameController get instance => Get.find();

  /// Text controller for the first name input field.
  final firstName = TextEditingController();

  /// Text controller for the last name input field.
  final lastName = TextEditingController();

  /// The user controller instance.
  final userController = UserController.instance;

  /// The user repository instance.
  final userRepository = Get.put(UserRepository());

  /// A global key for the update user name form.
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// Initializes the controller and sets the initial name values.
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Initializes the first and last name text fields with the user's current names.
  Future<void> initializeNames() async {
    firstName.text = userController.user.value!.firstName;
    lastName.text = userController.user.value!.lastName;
  }

  /// Updates the user's name in the backend and locally.
  Future<void> updateUserName() async {
    try {
      // Start Loading
      MagicFullScreenLoader.openLoadingDialog(
        'We are updating your information...',
        MagicImages.processingAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Hide loader
        MagicFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        MagicFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first & last name in backend
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim(),
      };
      await userRepository.updateSingleField(name);

      // Update the Rx User Value
      final updatedUser = userController.user.value!.copyWith(
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
      );
      userController.user.value = updatedUser;

      // Force UI update
      userController.update();

      // Redirect
      Get.back();

      // Stop Loading
      MagicFullScreenLoader.stopLoading();

      // Show Success Message
      MagicLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your name has been updated.',
      );
    } catch (e) {
      MagicFullScreenLoader.stopLoading();
      MagicLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
