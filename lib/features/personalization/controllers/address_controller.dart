import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/loaders/circular_loader.dart';
import 'package:magic_hardware/data/repositories/address/address_repository.dart';
import 'package:magic_hardware/features/personalization/models/address_model.dart';
import 'package:magic_hardware/utils/constants/image_strings.dart';
import 'package:magic_hardware/utils/formatters/formatter.dart';
import 'package:magic_hardware/utils/helpers/network_manager.dart';
import 'package:magic_hardware/utils/popups/full_screen_loader.dart';
import 'package:magic_hardware/utils/popups/loaders.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final address = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final island = TextEditingController();
  final atoll = TextEditingController();
  final postalCode = TextEditingController();
  final landmark = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());
  final dark = MagicHelperFunctions.isDarkMode(Get.context!);

  // Fetch all user specific addresses
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddress();
      selectedAddress.value = addresses.firstWhere(
        (element) => element.selectedAddress,
        orElse: () => AddressModel.empty(),
      );
      return addresses;
    } catch (e) {
      MagicLoaders.errorSnackBar(
        title: 'Address not found',
        message: e.toString(),
      );
      return [];
    }
  }

  // Add new address
  Future addNewAddress() async {
    try {
      // Start Loading
      MagicFullScreenLoader.openLoadingDialog(
        'Saving Address...',
        MagicImages.processingAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MagicFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        MagicFullScreenLoader.stopLoading();
        return;
      }

      final addressValue = AddressModel(
        id: '',
        address: address.text.trim(),
        phoneNumber: MagicFormatter.formatPhoneNumber(phoneNumber.text.trim()),
        street: street.text.trim(),
        island: island.text.trim(),
        atoll: atoll.text.trim(),
        postalCode: postalCode.text.trim(),
        landmark: landmark.text.trim(),
        selectedAddress: true,
      );

      // Add new address to the database
      final id = await addressRepository.addAddress(addressValue);

      // Update the ID in the address object
      addressValue.id = id;

      // Update Selected Address Status
      await selectAddress(addressValue);

      // Stop Loading
      MagicFullScreenLoader.stopLoading();

      // Show Success Message
      MagicLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your address has been saved successfully',
      );

      // Refresh Address Data
      refreshData.toggle();

      // Reset Fields
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      MagicFullScreenLoader.stopLoading();
      MagicLoaders.errorSnackBar(
        title: 'Error in Saving Address',
        message: e.toString(),
      );
    }
  }

  // Function to reset form fields
  void resetFormFields() {
    address.clear();
    phoneNumber.clear();
    street.clear();
    island.clear();
    atoll.clear();
    postalCode.clear();
    landmark.clear();
    addressFormKey.currentState?.reset();
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async => false,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const MagicCircularLoader(),
      );

      // Clear the previous selected address
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
          selectedAddress.value.id,
          false,
        );
      }

      // Update the selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // Update the selected address in the database
      await addressRepository.updateSelectedField(newSelectedAddress.id, true);

      Get.back();
    } catch (e) {
      MagicLoaders.errorSnackBar(
        title: 'Error in Selection',
        message: e.toString(),
      );
    }
  }

  // Delete address
  Future<void> deleteAddress(String addressId) async {
    try {
      // Show confirmation dialog
      Get.defaultDialog(
        title: 'Delete Address',
        middleText: 'Are you sure you want to delete this address? This action cannot be undone.',
        textConfirm: 'Delete',
        textCancel: 'Cancel',
        confirmTextColor: MagicColors.white,
        buttonColor: MagicColors.primary,
        cancelTextColor: dark ? MagicColors.white : MagicColors.black,
        onConfirm: () async {
          // Close the dialog
          Get.back();

          // Show loading
          Get.defaultDialog(
            title: '',
            onWillPop: () async => false,
            barrierDismissible: false,
            backgroundColor: Colors.transparent,
            content: const MagicCircularLoader(),
          );

          // Check if we're deleting the selected address
          final isDeletingSelectedAddress = selectedAddress.value.id == addressId;

          // Delete from database
          await addressRepository.deleteAddress(addressId);

          // If deleted address was selected, clear the selection
          if (isDeletingSelectedAddress) {
            selectedAddress.value = AddressModel.empty();
          }

          // Close loading dialog
          Get.back();

          // Refresh the address list
          refreshData.toggle();

          // Show success message
          MagicLoaders.successSnackBar(
            title: 'Address Deleted',
            message: 'Your address has been deleted successfully',
          );
        },
      );
    } catch (e) {
      // Close any open dialogs
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      MagicLoaders.errorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    }
  }

}
