import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/utils/constants/image_strings.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

import '../../models/payment_method_model.dart';
import '../../screens/checkout/widgets/payment_tile.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: 'Cash On Delivery', image: MagicImages.cashOnDelivery);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) =>  SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(MagicSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MagicSectionHeading(title: 'Select Payment Method', showActionButton: false),
              const SizedBox(height: MagicSizes.spaceBtwSections),
              MagicPaymentTile(paymentMethod: PaymentMethodModel(name: 'Cash On Delivery', image: MagicImages.cashOnDelivery)),
              const SizedBox(height: MagicSizes.spaceBtwItems / 2),
              MagicPaymentTile(paymentMethod: PaymentMethodModel(name: 'BML Transfer', image: MagicImages.bml)),
              const SizedBox(height: MagicSizes.spaceBtwItems / 2),
              MagicPaymentTile(paymentMethod: PaymentMethodModel(name: 'Visa', image: MagicImages.visa)),
              const SizedBox(height: MagicSizes.spaceBtwItems / 2),
              MagicPaymentTile(paymentMethod: PaymentMethodModel(name: 'MasterCard', image: MagicImages.masterCard)),
              const SizedBox(height: MagicSizes.spaceBtwItems / 2),
              MagicPaymentTile(paymentMethod: PaymentMethodModel(name: 'Google Pay', image: MagicImages.googlePay)),
              const SizedBox(height: MagicSizes.spaceBtwItems / 2),
              MagicPaymentTile(paymentMethod: PaymentMethodModel(name: 'Apple Pay', image: MagicImages.applePay)),
              const SizedBox(height: MagicSizes.spaceBtwItems / 2),
              MagicPaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal', image: MagicImages.paypal)),
              const SizedBox(height: MagicSizes.spaceBtwItems / 2),
              const SizedBox(height: MagicSizes.spaceBtwSections),
            ],
          ),
        ),
      )
    );
  }
}