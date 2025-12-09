/// Represents a product attribute.
class ProductAttributeModel {
  /// The name of the attribute (e.g., "Color", "Size").
  String? name;

  /// The list of possible values for the attribute (e.g. "Green", "Black", "no. 39", "no. 40").
  final List<String>? values;

  /// Creates a [ProductAttributeModel].
  ProductAttributeModel({this.name, this.values});

  /// Converts the [ProductAttributeModel] to a JSON object.
  Map<String, dynamic> toJson() {
    return {'Name': name, 'Values': values};
  }

  /// Creates a [ProductAttributeModel] from a JSON object.
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductAttributeModel();

    return ProductAttributeModel(
      name: data.containsKey('Name') ? data['Name'] : '',
      values: data['Values'] != null ? List<String>.from(data['Values']) : [],
    );
  }
}
