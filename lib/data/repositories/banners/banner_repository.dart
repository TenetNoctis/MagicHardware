import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/features/shop/models/banner_model.dart';

import '../../../utils/constants/text_strings.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

/// Repository for fetching and managing banner data from Firestore.
class BannerRepository extends GetxController {
  /// A static getter for the [BannerRepository] instance.
  static BannerRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  /// Fetches all active banners from the Firestore database.
  Future<List<BannerModel>> getAllBanners() async {
    try {
      final snapshot = await _db
          .collection('Banners')
          .where('Active', isEqualTo: true)
          .get();
      return snapshot.docs
          .map((document) => BannerModel.fromSnapshot(document))
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
