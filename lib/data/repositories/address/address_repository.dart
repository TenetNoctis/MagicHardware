import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/data/repositories/authentication/authentication_repository.dart';

import '../../../features/personalization/models/address_model.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final userId = AuthenticationRepository.instance.authUser!.uid;

  Future<List<AddressModel>> fetchUserAddress() async {
    try {
      if (userId.isEmpty) throw 'Unable to find user information. Try again later!';
      final result = await _db.collection('Users').doc(userId).collection('Addresses').get();
      return result.docs.map((documentSnapshot) => AddressModel.fromDocumentSnapshot(documentSnapshot)).toList();
    } catch (e) {
      throw Exception('Failed to fetch user addresses: $e');
    }
  }

  // Store new address
  Future<String> addAddress(AddressModel address) async {
    try {
      final currentAddress = _db.collection('Users').doc(userId).collection('Addresses').doc();
      address.id = currentAddress.id;
      await currentAddress.set(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw 'Something went wrong while saving your address. Try again later';
    }
  }

  // Update selected field
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      await _db.collection('Users').doc(userId).collection('Addresses').doc(addressId).update({'Selected Address': selected});
    } catch (e) {
      throw 'Unable to update your address selection. Try again later';
    }
  }

  // Delete address
  Future<void> deleteAddress(String addressId) async {
    try {
      if (userId.isEmpty) throw 'Unable to find user information. Try again later!';
      await _db.collection('Users').doc(userId).collection('Addresses').doc(addressId).delete();
    } catch (e) {
      throw 'Unable to delete address. Try again later: $e';
    }
  }
}