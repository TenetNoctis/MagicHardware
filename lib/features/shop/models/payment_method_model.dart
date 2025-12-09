/// A model for a payment method.
class PaymentMethodModel {
  /// The name of the payment method.
  String name;

  /// The image for the payment method.
  String image;

  /// Creates a new [PaymentMethodModel].
  PaymentMethodModel({required this.name, required this.image});

  /// Creates an empty [PaymentMethodModel].
  static PaymentMethodModel empty() => PaymentMethodModel(name: '', image: '');
}
