import 'package:get/get.dart';
import 'package:magic_hardware/data/repositories/user/user_repository.dart';
import 'package:magic_hardware/features/personalization/controllers/user_controller.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

/// Controller for updating the user's gender.
class UpdateGenderController extends GetxController {
  /// Provides a singleton instance of the [UpdateGenderController].
  static UpdateGenderController get instance => Get.find();

  /// The currently selected gender.
  final selectedGender = 'Male'.obs;

  /// The user controller instance.
  final userController = UserController.instance;

  /// The user repository instance.
  final userRepository = Get.put(UserRepository());

  /// Initializes the controller and sets the initial gender value.
  @override
  void onInit() {
    initializeGender();
    super.onInit();
  }

  /// Initializes the gender selection with the user's current gender.
  Future<void> initializeGender() async {
    selectedGender.value = userController.user.value!.gender;
  }

  /// Updates the user's gender in the backend and locally.
  Future<void> updateGender() async {
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

      // Update user's gender in backend
      Map<String, dynamic> gender = {'Gender': selectedGender.value};
      await userRepository.updateSingleField(gender);

      // Update the Rx User Value
      final updatedUser = userController.user.value!.copyWith(
        gender: selectedGender.value,
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
        message: 'Your gender has been updated.',
      );
    } catch (e) {
      MagicFullScreenLoader.stopLoading();
      MagicLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
