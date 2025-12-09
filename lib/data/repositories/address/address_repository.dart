import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/data/repositories/authentication/authentication_repository.dart';
import 'package:magic_hardware/utils/constants/text_strings.dart';

import '../../../features/personalization/models/address_model.dart';

/// A repository for managing user addresses.
class AddressRepository extends GetxController {
  /// A static getter for the [AddressRepository] instance.
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// The ID of the current authenticated user.
  final userId = AuthenticationRepository.instance.authUser!.uid;

  /// Fetches the list of addresses for the current user.
  Future<List<AddressModel>> fetchUserAddress() async {
    try {
      if (userId.isEmpty) {
        throw MagicTexts.unableToFindUser;
      }
      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .get();
      return result.docs
          .map(
            (documentSnapshot) =>
                AddressModel.fromDocumentSnapshot(documentSnapshot),
          )
          .toList();
    } catch (e) {
      throw Exception('${MagicTexts.fetchUserAddressesError}$e');
    }
  }

  /// Stores a new address for the current user.
  Future<String> addAddress(AddressModel address) async {
    try {
      final currentAddress = _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc();
      address.id = currentAddress.id;
      await currentAddress.set(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw MagicTexts.addAddressError;
    }
  }

  /// Updates the 'Selected Address' field for a given address.
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'Selected Address': selected});
    } catch (e) {
      throw MagicTexts.updateAddressError;
    }
  }

  /// Deletes a specific address for the current user.
  Future<void> deleteAddress(String addressId) async {
    try {
      if (userId.isEmpty) {
        throw MagicTexts.unableToFindUser;
      }
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .delete();
    } catch (e) {
      throw '${MagicTexts.deleteAddressError}$e';
    }
  }
}
