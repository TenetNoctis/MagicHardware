import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/success_screen/success_screen.dart';
import 'package:magic_hardware/navigation_menu.dart';
import 'package:magic_hardware/utils/constants/enums.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/orders/order_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/address_controller.dart';
import '../../models/order_model.dart';
import 'cart_controller.dart';
import 'checkout_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  // Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      MagicLoaders.errorSnackBar(title: 'Error', message: e.toString());
      return [];
    }
  }

  // Process Order
  void processOrder(double totalAmount) async {
    try {
      // Start Loader
      MagicFullScreenLoader.openLoadingDialog(
        'Processing Order...',
        MagicImages.processingAnimation,
      );

      // Get user authentication id
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null || userId.isEmpty) return;

      // Add Details
      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.processing,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now().add(const Duration(days: 3)),
        items: cartController.cartItems.toList(),
      );

      // Save Order to Firestore
      await orderRepository.saveOrder(order, userId);

      // Stop Loader
      MagicFullScreenLoader.stopLoading();

      // Update the cart status
      cartController.clearCart();

      // Show Success Screen
      Get.off(
        () => SuccessScreen(
          image: MagicImages.successAnimation,
          title: 'Payment Success',
          subTitle: 'Your items will be shipped soon!',
          onPressed: () => Get.offAll(() => const NavigationMenu()),
        ),
      );
    } catch (e) {
      MagicFullScreenLoader.stopLoading();
      MagicLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
