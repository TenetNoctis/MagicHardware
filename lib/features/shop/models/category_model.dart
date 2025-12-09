import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a category in the application.
class CategoryModel {
  /// The ID of the category.
  String id;

  /// The name of the category.
  String name;

  /// The URL of the category's image.
  String image;

  /// The ID of the parent category, if any.
  String parentId;

  /// Whether the category is featured.
  bool isFeatured;

  /// The URL of the category's banner image, if any.
  String? bannerImage;

  /// Creates a [CategoryModel].
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = '',
    required this.isFeatured,
    this.bannerImage,
  });

  /// Creates an empty [CategoryModel].
  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', image: '', isFeatured: false);

  /// Converts the [CategoryModel] to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
      'BannerImage': bannerImage,
    };
  }

  /// Creates a [CategoryModel] from a Firestore [DocumentSnapshot].
  factory CategoryModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;

      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        bannerImage: data['BannerImage'] ?? '',
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
