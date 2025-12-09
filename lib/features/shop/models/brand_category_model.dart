import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents the relationship between a brand and a category.
class BrandCategoryModel {
  /// The ID of the brand.
  final String brandId;

  /// The ID of the category.
  final String categoryId;

  /// Creates a [BrandCategoryModel].
  BrandCategoryModel({required this.brandId, required this.categoryId});

  /// Converts the [BrandCategoryModel] to a JSON object.
  Map<String, dynamic> toJson() {
    return {'brandId': brandId, 'categoryId': categoryId};
  }

  /// Creates a [BrandCategoryModel] from a Firestore [DocumentSnapshot].
  factory BrandCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BrandCategoryModel(
      brandId: data['brandId'] ?? '',
      categoryId: data['categoryId'] ?? '',
    );
  }
}
