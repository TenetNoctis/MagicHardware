import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_hardware/features/personalization/models/address_model.dart';
import 'package:magic_hardware/features/shop/models/cart_item_model.dart';
import 'package:magic_hardware/utils/constants/enums.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

/// Represents an order.
class OrderModel {
  /// The unique identifier for the order.
  final String id;

  /// The ID of the user who placed the order.
  final String userId;

  /// The status of the order.
  final OrderStatus status;

  /// The total amount of the order.
  final double totalAmount;

  /// The date the order was placed.
  final DateTime orderDate;

  /// The payment method used for the order.
  final String paymentMethod;

  /// The shipping address for the order.
  final AddressModel? address;

  /// The date the order is expected to be delivered.
  final DateTime? deliveryDate;

  /// The items in the order.
  final List<CartItemModel> items;

  /// Creates an [OrderModel].
  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = 'Cash on Delivery',
    this.address,
    this.deliveryDate,
  });

  /// Returns the formatted order date string.
  String get formattedOrderDate =>
      MagicHelperFunctions.getFormattedDate(orderDate);

  /// Returns the formatted delivery date string.
  String get formattedDeliveryDate => deliveryDate != null
      ? MagicHelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  /// Returns the string representation of the order status.
  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
      ? 'Shipment on the way'
      : 'Processing';

  /// Converts the [OrderModel] to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'address': address?.toJson(),
      'deliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  /// Creates an [OrderModel] from a Firestore snapshot.
  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return OrderModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      status: OrderStatus.values.firstWhere(
        (status) => status.toString() == data['status'],
      ),
      totalAmount: data['totalAmount'] as double,
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'] as String,
      address: AddressModel.fromMap(data['address'] as Map<String, dynamic>),
      deliveryDate: data['deliveryDate'] == null
          ? null
          : (data['deliveryDate'] as Timestamp).toDate(),
      items: (data['items'] as List<dynamic>)
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
