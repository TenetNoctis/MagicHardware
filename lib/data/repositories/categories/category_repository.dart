import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/features/shop/models/category_model.dart';

import '../../../utils/constants/text_strings.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

/// A repository for managing category-related data.
class CategoryRepository extends GetxController {
  /// A static getter for the [CategoryRepository] instance.
  static CategoryRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  /// Fetches all categories from the database.
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      return snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      throw MagicTexts.somethingWentWrong;
    }
  }

  /// Fetches all sub-categories for a given category ID.
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db
          .collection('Categories')
          .where('ParentId', isEqualTo: categoryId)
          .get();
      return snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      throw MagicTexts.somethingWentWrong;
    }
  }
}
