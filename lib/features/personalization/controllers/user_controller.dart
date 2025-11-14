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
import '../models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel?> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // Fetch User Record
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

  // Save user record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // Refresh User Record
      await fetchUserRecord();

      // If no user record exists
      if (user.value!.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Name to First and Last Name
          final nameparts = UserModel.nameParts(
            userCredentials.user!.displayName ?? '',
          );
          final username = UserModel.generateUsername(
            userCredentials.user!.displayName ?? '',
          );

          // Map Data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameparts[0],
            lastName: nameparts.length > 1
                ? nameparts.sublist(1).join(' ')
                : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
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

  // Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(MagicSizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account?',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: MagicSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  // Delete User Account
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

  // Re-Authenticate User before deleting
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

  // Upload Profile Image
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
