import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents the relationship between a product and a category.
class ProductCategoryModel {
  /// The ID of the product.
  final String productId;

  /// The ID of the category.
  final String categoryId;

  /// Creates a [ProductCategoryModel].
  ProductCategoryModel({required this.productId, required this.categoryId});

  /// Converts the [ProductCategoryModel] to a JSON object.
  Map<String, dynamic> toJson() {
    return {'productId': productId, 'categoryId': categoryId};
  }

  /// Creates a [ProductCategoryModel] from a Firestore [DocumentSnapshot].
  factory ProductCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProductCategoryModel(
      productId: data['productId'] ?? '',
      categoryId: data['categoryId'] ?? '',
    );
  }
}
