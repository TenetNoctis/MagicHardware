import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/features/shop/screens/order/widgets/orders_list.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

/// A screen that displays the user's orders.
class OrderScreen extends StatelessWidget {
  /// Creates an [OrderScreen].
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: MagicAppBar(
        title: Text(
          'My Orders',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),

      // Orders
      body: const Padding(
        padding: EdgeInsets.all(MagicSizes.defaultSpace),
        child: MagicOrderListItems(),
      ),
    );
  }
}
