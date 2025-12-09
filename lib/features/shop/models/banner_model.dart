import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a banner in the application.
class BannerModel {
  /// The URL of the banner image.
  String imageUrl;

  /// The screen to navigate to when the banner is tapped.
  final String? targetScreen;

  /// Whether the banner is currently active.
  final bool active;

  /// The ID of the product associated with the banner, if any.
  final String? productId;

  /// Creates a [BannerModel].
  BannerModel({
    required this.imageUrl,
    this.productId,
    this.targetScreen,
    required this.active,
  });

  /// Converts the [BannerModel] to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'ImageUrl': imageUrl,
      'TargetScreen': targetScreen,
      'Active': active,
      'ProductId': productId,
    };
  }

  /// Creates a [BannerModel] from a Firestore [DocumentSnapshot].
  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
      imageUrl: data['ImageUrl'] ?? '',
      targetScreen: data['TargetScreen'] ?? '',
      active: data['Active'] ?? false,
      productId: data['ProductId'] ?? '',
    );
  }
}
