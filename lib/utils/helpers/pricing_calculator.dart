/// A class for calculating pricing, including subtotal, total price, tax, and shipping.
///
/// This class provides static methods to perform common pricing calculations.
class MagicPricingCalculator {
  /// Calculates the subtotal of a product by removing the tax.
  ///
  /// The tax rate is determined by the [location].
  /// Returns the price of the product before tax.
  static double calculateSubTotal(double productPrice, String location) {
    double subTotal = productPrice / (1 + getTaxRateForLocation(location));
    return subTotal;
  }

  /// Calculates the total price of a product, including tax and shipping.
  ///
  /// - [productPrice]: The base price of the product.
  /// - [location]: The location to which the product will be shipped, used to determine tax and shipping cost.
  ///
  /// Returns the total price, including tax and shipping.
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    double shippingCost = getShippingCost(location);
    double totalPrice = productPrice + taxAmount + shippingCost;
    return totalPrice;
  }

  /// Calculates the shipping cost for a given [location].
  ///
  /// Returns the shipping cost as a string with two decimal places.
  static String calculateShippingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  /// Calculates the tax for a given [productPrice] and [location].
  ///
  /// The tax rate is determined by the [location].
  /// Returns the tax amount as a string with two decimal places.
  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  /// Returns the tax rate for a given [location].
  ///
  /// Note: This is a simplified implementation.
  static double getTaxRateForLocation(String location) {
    return 0.08;
  }

  /// Returns the shipping cost for a given [location].
  ///
  /// Note: This is a simplified implementation.
  static double getShippingCost(String location) {
    return 10.00;
  }
}
