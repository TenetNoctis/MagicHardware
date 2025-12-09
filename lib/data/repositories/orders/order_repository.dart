import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/data/repositories/authentication/authentication_repository.dart';

import '../../../features/shop/models/order_model.dart';
import '../../../utils/constants/text_strings.dart';

/// A repository for managing user orders.
class OrderRepository extends GetxController {
  /// A static getter for the [OrderRepository] instance.
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Fetches all orders for the current user.
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null || userId.isEmpty) throw MagicTexts.unableToFindUser;
      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .get();
      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw MagicTexts.somethingWentWrong;
    }
  }

  /// Saves a new order for a specific user.
  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
    } catch (e) {
      throw MagicTexts.somethingWentWrong;
    }
  }
}
