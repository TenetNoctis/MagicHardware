import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/success_screen/success_screen.dart';
import 'package:magic_hardware/data/repositories/authentication/authentication_repository.dart';
import 'package:magic_hardware/utils/constants/image_strings.dart';
import 'package:magic_hardware/utils/constants/text_strings.dart';
import 'package:magic_hardware/utils/popups/loaders.dart';

/// Controller for handling email verification.
class VerifyEmailController extends GetxController {
  /// Provides a singleton instance of the [VerifyEmailController].
  static VerifyEmailController get instance => Get.find();

  /// Sends an email whenever the verification screen appears and sets a timer for auto-redirection.
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// Sends an email verification link to the user.
  Future<void> sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      MagicLoaders.successSnackBar(
        title: 'Email Sent',
        message: 'Please check your inbox and verify your email.',
      );
    } catch (e) {
      MagicLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Sets a timer to automatically redirect the user upon email verification.
  void setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => SuccessScreen(
            image: MagicImages.successAnimation,
            title: MagicTexts.yourAccountCreatedTitle,
            subTitle: MagicTexts.yourAccountCreatedSubTitle,
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ),
        );
      }
    });
  }

  /// Manually checks if the user's email has been verified.
  Future<void> checkEmailVerified() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    await currentUser?.reload();
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
          image: MagicImages.successAnimation,
          title: MagicTexts.yourAccountCreatedTitle,
          subTitle: MagicTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    }
  }
}
