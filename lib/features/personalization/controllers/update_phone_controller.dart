import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/data/repositories/user/user_repository.dart';
import 'package:magic_hardware/features/personalization/controllers/user_controller.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../../utils/formatters/formatter.dart';

class UpdatePhoneController extends GetxController {
  static UpdatePhoneController get instance => Get.find();

  final phoneNumber = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updatePhoneFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializePhoneNumber();
    super.onInit();
  }

  Future<void> initializePhoneNumber() async {
    phoneNumber.text = userController.user.value!.phoneNumber;
  }

  Future<void> updatePhoneNumber() async {
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
      if (!updatePhoneFormKey.currentState!.validate()) {
        MagicFullScreenLoader.stopLoading();
        return;
      }

      // Format the phone number before updating
      String formattedPhone = MagicFormatter.formatPhoneNumber(phoneNumber.text.trim());

      // Update user's phone number in backend
      Map<String, dynamic> phone = {
        'PhoneNumber': formattedPhone,
      };
      await userRepository.updateSingleField(phone);

      // Update the Rx User Value
      final updatedUser = userController.user.value!.copyWith(
        phoneNumber: formattedPhone,
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
        message: 'Your phone number has been updated.',
      );

    } catch (e) {
      MagicFullScreenLoader.stopLoading();
      MagicLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}