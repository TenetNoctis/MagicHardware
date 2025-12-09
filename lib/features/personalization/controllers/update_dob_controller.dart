import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/data/repositories/user/user_repository.dart';
import 'package:magic_hardware/features/personalization/controllers/user_controller.dart';
import 'package:magic_hardware/utils/formatters/formatter.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

/// Controller for updating the user's date of birth.
class UpdateDobController extends GetxController {
  /// Provides a singleton instance of the [UpdateDobController].
  static UpdateDobController get instance => Get.find();

  /// Text controller for the date of birth input field.
  final dateOfBirth = TextEditingController();

  /// The user controller instance.
  final userController = UserController.instance;

  /// The user repository instance.
  final userRepository = Get.put(UserRepository());

  /// A global key for the update date of birth form.
  GlobalKey<FormState> updateDobFormKey = GlobalKey<FormState>();

  /// Initializes the controller and sets the initial date of birth value.
  @override
  void onInit() {
    initializeDateOfBirth();
    super.onInit();
  }

  /// Initializes the date of birth text field with the user's current date of birth.
  Future<void> initializeDateOfBirth() async {
    dateOfBirth.text = userController.user.value!.dateOfBirth;
  }

  /// Displays a date picker and updates the text field with the selected date.
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 18 * 365)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dateOfBirth.text = MagicFormatter.formatDate(picked);
    }
  }

  /// Updates the user's date of birth in the backend and locally.
  Future<void> updateDateOfBirth() async {
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
      if (!updateDobFormKey.currentState!.validate()) {
        MagicFullScreenLoader.stopLoading();
        return;
      }

      // Update user's date of birth in backend
      Map<String, dynamic> dob = {'DateOfBirth': dateOfBirth.text.trim()};
      await userRepository.updateSingleField(dob);

      // Update the Rx User Value
      final updatedUser = userController.user.value!.copyWith(
        dateOfBirth: dateOfBirth.text.trim(),
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
        message: 'Your date of birth has been updated.',
      );
    } catch (e) {
      MagicFullScreenLoader.stopLoading();
      MagicLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
