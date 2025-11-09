import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:magic_hardware/features/authentication/screens/login/login.dart';
import 'package:magic_hardware/features/authentication/screens/onboarding/onboarding.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  Future<void> screenRedirect() async {
    // Local Storage
    deviceStorage.writeIfNull('IsFirstTime', true);
    deviceStorage.read('IsFirstTime') != true
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => const OnBoardingScreen());
  }

  /* ----------------------------------- Email & Password sign-in ----------------------------------- */

  // [EmailAuthentication] - SignIn

  // [EmailAuthentication] - Register

  // [ReAuthenticate] - ReAuthenticate User

  // [EmailVerification] - Email Verification

  // [PasswordReset] - Password Reset

  /* ----------------------------------- Federated identity & Social sign-in ----------------------------------- */

  // [GoogleAuthentication] - Google
  // [FacebookAuthentication] - Facebook

  /* ----------------------------------- ./ endFederated identity & Social sign-in ----------------------------------- */

  // [LogoutUser] - Valid for all authentication

  // [DeleteUser] - Remove user Auth and Firestore Account
}
