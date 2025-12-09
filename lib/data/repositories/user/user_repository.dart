import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magic_hardware/data/repositories/authentication/authentication_repository.dart';

import '../../../features/personalization/models/user_model.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

/// A repository for managing user-related data and operations.
class UserRepository extends GetxController {
  /// Provides a singleton instance of the [UserRepository].
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Saves user data to Firestore.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MagicFormatException();
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      throw MagicTexts.somethingWentWrong;
    }
  }

  /// Fetches user details from Firestore based on the current user's ID.
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MagicFormatException();
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      throw MagicTexts.somethingWentWrong;
    }
  }

  /// Updates user data in Firestore.
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection('Users')
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MagicFormatException();
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      throw MagicTexts.somethingWentWrong;
    }
  }

  /// Updates a single field in a specific user's collection.
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MagicFormatException();
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      throw MagicTexts.somethingWentWrong;
    }
  }

  /// Removes a user's data from Firestore.
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MagicFormatException();
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      throw MagicTexts.somethingWentWrong;
    }
  }

  /// Uploads an image to Firebase Storage and returns its URL.
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MagicFormatException();
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      throw MagicTexts.somethingWentWrong;
    }
  }
}
