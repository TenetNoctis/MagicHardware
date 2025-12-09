import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/data/repositories/authentication/authentication_repository.dart';
import 'package:magic_hardware/utils/popups/full_screen_loader.dart';
import 'package:magic_hardware/utils/popups/loaders.dart';

import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../personalization/models/user_model.dart';

/// Controller for handling the user signup process.
class SignupController extends GetxController {
  /// Provides a singleton instance of the [SignupController].
  static SignupController get instance => Get.find();

  /// Indicates whether the password should be hidden or visible.
  final hidePassword = true.obs;

  /// Indicates whether the user has accepted the privacy policy.
  final privacyPolicy = true.obs;

  /// Text controller for the first name input field.
  final firstName = TextEditingController();

  /// Text controller for the last name input field.
  final lastName = TextEditingController();

  /// Text controller for the username input field.
  final username = TextEditingController();

  /// Text controller for the email input field.
  final email = TextEditingController();

  /// Text controller for the phone number input field.
  final phoneNumber = TextEditingController();

  /// Text controller for the password input field.
  final password = TextEditingController();

  /// A global key for the signup form.
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// Handles the user signup process.
  Future<void> signup() async {
    try {
      // Start Loading
      MagicFullScreenLoader.openLoadingDialog(
        'We are processing your information',
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
      if (!signupFormKey.currentState!.validate()) {
        // Hide loader
        MagicFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        MagicLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.',
        );
        return;
      }

      // Register user in the Firebase Authentication & Save user data in the Firebase
      final user = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
            email.text.trim(),
            password.text.trim(),
          );

      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: user.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Hide loader
      MagicFullScreenLoader.stopLoading();

      // Show Success Message
      MagicLoaders.successSnackBar(
        title: 'Congratulations',
        message:
            'Your account has been successfully created! Verify email to continue',
      );

      // Move to Verify Email Screen
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Hide loader
      MagicFullScreenLoader.stopLoading();

      // Show generic error
      MagicLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
