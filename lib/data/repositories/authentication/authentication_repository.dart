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
import 'package:magic_hardware/utils/local_storage/storage_utility.dart';

import '../../../utils/constants/text_strings.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

/// A repository for handling user authentication.
class AuthenticationRepository extends GetxController {
  /// A static getter for the [AuthenticationRepository] instance.
  static AuthenticationRepository get instance => Get.find();

  /// A handle to the device's local storage.
  final deviceStorage = GetStorage();

  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;

  /// Gets the current authenticated user.
  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Redirects the user to the appropriate screen based on their authentication status.
  Future<void> screenRedirect() async {
    User? user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        await MagicLocalStorage.init(user.uid);
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

  /// Signs in a user with their email and password.
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
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
      throw MagicTexts.somethingWentWrong;
    }
  }

  /// Registers a new user with their email and password.
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
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
      throw MagicTexts.somethingWentWrong;
    }
  }

  /// Re-authenticates the current user with their email and password.
  Future<void> reAuthenticateWithEmailAndPassword(
    String email,
    String password,
  ) async {
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
      throw MagicTexts.somethingWentWrong;
    }
  }

  /// Sends an email verification link to the current user.
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
      throw MagicTexts.somethingWentWrong;
    }
  }

  /// Sends a password reset email to the given email address.
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
      throw MagicTexts.somethingWentWrong;
    }
  }

  /* ----------------------------------- Federated identity & Social sign-in ----------------------------------- */

  /// Signs in a user with their Google account.
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

  /// Logs out the current user.
  Future<void> logout() async {
    try {
      MagicLocalStorage.reset();
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
      throw MagicTexts.somethingWentWrong;
    }
  }

  /// Deletes the current user's account.
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
      throw MagicTexts.somethingWentWrong;
    }
  }
}
