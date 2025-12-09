import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a brand in the application.
class BrandModel {
  /// The ID of the brand.
  String id;

  /// The name of the brand.
  String name;

  /// The URL of the brand's image.
  String image;

  /// Whether the brand is featured.
  bool? isFeatured;

  /// The number of products associated with the brand.
  int? productsCount;

  /// Creates a [BrandModel].
  BrandModel({
    required this.id,
    required this.image,
    required this.name,
    this.isFeatured,
    this.productsCount,
  });

  /// Creates an empty [BrandModel].
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  /// Converts the [BrandModel] to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
    };
  }

  /// Creates a [BrandModel] from a JSON object.
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      productsCount: data['ProductsCount'] ?? 0,
    );
  }

  /// Creates a [BrandModel] from a Firestore [DocumentSnapshot].
  factory BrandModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data();
      return BrandModel(
        id: document.id,
        name: data?['Name'] ?? '',
        image: data?['Image'] ?? '',
        isFeatured: data?['IsFeatured'] ?? false,
        productsCount: data?['ProductsCount'] ?? 0,
      );
    } else {
      return BrandModel.empty();
    }
  }
}
