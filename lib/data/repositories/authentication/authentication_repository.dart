import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:magic_hardware/data/repositories/user/user_repository.dart';
import 'package:magic_hardware/features/authentication/screens/login/login.dart';
import 'package:magic_hardware/features/authentication/screens/onboarding/onboarding.dart';
import 'package:magic_hardware/features/authentication/screens/signup/verify_email.dart';
import 'package:magic_hardware/navigation_menu.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  // Function to redirect user to the proper screen
  Future<void> screenRedirect() async {
    User? user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      // Local Storage
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  /* ----------------------------------- Email & Password sign-in ----------------------------------- */

  // [EmailAuthentication] - SignIn
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw MagicFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on FormatException {
      throw const MagicFormatException();
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // [EmailAuthentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw MagicFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on FormatException {
      throw const MagicFormatException();
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // [ReAuthenticate] - ReAuthenticate User
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw MagicFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on FormatException {
      throw const MagicFormatException();
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // [EmailVerification] - Email Verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw MagicFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on FormatException {
      throw const MagicFormatException();
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // [PasswordReset] - Password Reset
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw MagicFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on FormatException {
      throw const MagicFormatException();
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /* ----------------------------------- Federated identity & Social sign-in ----------------------------------- */

  // [GoogleAuthentication] - Google
  Future<UserCredential?> signInWithGoogle() async {
    try {

      // Initialize Google Sign In
      if (!_isGoogleSignInInitialized) {
        try {
          await _googleSignIn.initialize();
          _isGoogleSignInInitialized = true;
        } catch (e) {
          if (kDebugMode) {
            print('Failed to initialize Google Sign-In: $e');
          }
        }
      }

      // Authenticate with Google
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
        scopeHint: ['email'],
      );

      // Get authorization for Firebase scopes if needed
      final authClient = _googleSignIn.authorizationClient;
      final authorization = await authClient.authorizationForScopes(['email']);

      final credential = GoogleAuthProvider.credential(
        accessToken: authorization?.accessToken,
        idToken: googleUser.authentication.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw MagicFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on FormatException {
      throw const MagicFormatException();
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }

  // [FacebookAuthentication] - Facebook

  /* ----------------------------------- ./end Federated identity & Social sign-in ----------------------------------- */

  // [LogoutUser] - Valid for all authentication
  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw MagicFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on FormatException {
      throw const MagicFormatException();
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // [DeleteUser] - Remove user Auth and Firestore Account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw MagicFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on FormatException {
      throw const MagicFormatException();
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
