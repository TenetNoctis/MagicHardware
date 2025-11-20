import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/brand_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  // Get All Categories
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final result = await _db.collection('Brands').get();
      return result.docs.map((documentSnapshot) => BrandModel.fromSnapshot(documentSnapshot)).toList();
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MagicFormatException();
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Get Brands For Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      QuerySnapshot brandCategoryQuery = await _db.collection('BrandCategory').where('categoryId', isEqualTo: categoryId).get();
      List<String> brandIds = brandCategoryQuery.docs.map((documentSnapshot) => documentSnapshot['brandId'] as String).toList();
      final brandsQuery = await _db.collection('Brands').where(FieldPath.documentId, whereIn: brandIds).get();
      List<BrandModel> brands = brandsQuery.docs.map((documentSnapshot) => BrandModel.fromSnapshot(documentSnapshot)).toList();
      return brands;
    } on FirebaseException catch (e) {
      throw MagicFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const MagicFormatException();
    } on PlatformException catch (e) {
      throw MagicPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
