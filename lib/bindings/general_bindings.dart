import 'package:get/get.dart';
import 'package:magic_hardware/features/shop/controllers/product/variation_controller.dart';

import '../features/shop/controllers/product/checkout_controller.dart';
import '../utils/helpers/network_manager.dart';

/// A class that sets up general bindings for the application.
///
/// This class is responsible for initializing and registering controllers and services
/// that are used throughout the application.
class GeneralBindings extends Bindings {
  /// Sets up the dependencies for the application.
  ///
  /// This method is called by the GetX framework to register the necessary
  /// controllers and services.
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(CheckoutController());
  }
}
