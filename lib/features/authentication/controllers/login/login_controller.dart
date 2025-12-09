import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:magic_hardware/data/repositories/authentication/authentication_repository.dart';
import 'package:magic_hardware/utils/popups/loaders.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../personalization/controllers/user_controller.dart';

/// Controller for handling user login.
class LoginController extends GetxController {
  /// Indicates whether the user wants their email to be remembered.
  final rememberMe = false.obs;

  /// Indicates whether the password should be hidden or visible.
  final hidePassword = true.obs;

  /// A handle to the device's local storage.
  final localStorage = GetStorage();

  /// Text controller for the email input field.
  final email = TextEditingController();

  /// Text controller for the password input field.
  final password = TextEditingController();

  /// A global key for the login form.
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  /// Controller for managing user-related data.
  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    super.onInit();
  }

  /// Handles the email and password sign-in process.
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      MagicFullScreenLoader.openLoadingDialog(
        'Logging you in...',
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
      if (!loginFormKey.currentState!.validate()) {
        // Hide loader
        MagicFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if remember me is checked
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
      } else {
        localStorage.remove('REMEMBER_ME_EMAIL');
      }

      await AuthenticationRepository.instance.signInWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // Hide loader
      MagicFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Hide loader
      MagicFullScreenLoader.stopLoading();
      MagicLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Handles the Google sign-in process.
  Future<void> googleSignIn() async {
    try {
      // Start Loading
      MagicFullScreenLoader.openLoadingDialog(
        'Logging you in...',
        MagicImages.processingAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Hide loader
        MagicFullScreenLoader.stopLoading();
        return;
      }

      // Google Authentication
      final userCredentials = await AuthenticationRepository.instance
          .signInWithGoogle();

      // Save User Record
      await userController.saveUserRecord(userCredentials);

      // Hide loader
      MagicFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      MagicLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
