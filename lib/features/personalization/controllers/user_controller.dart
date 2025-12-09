import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magic_hardware/data/repositories/authentication/authentication_repository.dart';
import 'package:magic_hardware/features/authentication/screens/login/login.dart';
import 'package:magic_hardware/features/personalization/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:magic_hardware/utils/constants/image_strings.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/network_manager.dart';
import 'package:magic_hardware/utils/popups/full_screen_loader.dart';
import 'package:magic_hardware/utils/popups/loaders.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../models/user_model.dart';

/// Controller for managing user-related operations.
class UserController extends GetxController {
  /// Singleton instance of [UserController].
  static UserController get instance => Get.find();

  /// Observable for profile loading state.
  final profileLoading = false.obs;

  /// Observable for the current user.
  Rx<UserModel?> user = UserModel.empty().obs;

  /// Observable for password visibility.
  final hidePassword = false.obs;

  /// Observable for image uploading state.
  final imageUploading = false.obs;

  /// Controller for the verify email text field.
  final verifyEmail = TextEditingController();

  /// Controller for the verify password text field.
  final verifyPassword = TextEditingController();

  /// Repository for user-related database operations.
  final userRepository = Get.put(UserRepository());

  /// Global key for the re-authentication form.
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  /// Flag to determine if the current theme is dark mode.
  final dark = MagicHelperFunctions.isDarkMode(Get.context!);

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// Fetches the user record from the database.
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Saves the user record from any registration provider.
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Refresh User Record
      await fetchUserRecord();

      // If no user record exists
      if (user.value!.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Name to First and Last Name
          final nameParts = UserModel.nameParts(
            userCredentials.user!.displayName ?? '',
          );
          final username = UserModel.generateUsername(
            userCredentials.user!.displayName ?? '',
          );

          // Map Data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1
                ? nameParts.sublist(1).join(' ')
                : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
            gender: '',
            dateOfBirth: '',
          );

          // Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      MagicLoaders.warningSnackBar(
        title: 'Data not saved',
        message: 'Something went wrong while saving your information',
      );
    }
  }

  /// Displays a popup to confirm account deletion.
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(MagicSizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account?',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      cancelTextColor: dark ? MagicColors.white : MagicColors.black,
      onConfirm: () async => deleteUserAccount(),
    );
  }

  /// Deletes the user account.
  void deleteUserAccount() async {
    try {
      MagicFullScreenLoader.openLoadingDialog(
        'Processing',
        MagicImages.processingAnimation,
      );

      // First Re-Authenticate User
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData
          .map((e) => e.providerId)
          .first;
      if (provider.isNotEmpty) {
        // Re-Verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          MagicFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          MagicFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      MagicFullScreenLoader.stopLoading();
      MagicLoaders.warningSnackBar(
        title: 'Oh Snap',
        message: 'Something went wrong while deleting your account',
      );
    }
  }

  /// Re-authenticates the user with email and password.
  void reAuthenticateEmailAndPasswordUser() async {
    try {
      MagicFullScreenLoader.openLoadingDialog(
        'Processing',
        MagicImages.processingAnimation,
      );

      // Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MagicFullScreenLoader.stopLoading();
        return;
      }

      // Validate
      if (!reAuthFormKey.currentState!.validate()) {
        MagicFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
            verifyEmail.text.trim(),
            verifyPassword.text.trim(),
          );
      await AuthenticationRepository.instance.deleteAccount();
      MagicFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      MagicFullScreenLoader.stopLoading();
      MagicLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// Uploads the user's profile picture.
  Future<void> uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        imageUploading.value = true;

        // Upload Image
        final imageUrl = await userRepository.uploadImage(
          ('Users/Images/Profile'),
          image,
        );

        // Update User Image Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        // Update Image Locally
        user.update((val) {
          val?.profilePicture = imageUrl;
        });

        // Refresh User Locally
        user.refresh();

        MagicLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Profile Image has been updated!',
        );
      }
    } catch (e) {
      MagicLoaders.warningSnackBar(
        title: 'Oh Snap!',
        message: 'Something went wrong: $e',
      );
    } finally {
      imageUploading.value = false;
    }
  }
}
