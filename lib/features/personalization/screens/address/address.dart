import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/appbar/appbar.dart';
import 'package:magic_hardware/features/personalization/screens/address/widgets/single_address.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../controllers/address_controller.dart';
import 'add_new_address.dart';

/// A screen that displays a list of the user's addresses.
class UserAddressScreen extends StatelessWidget {
  /// Creates a [UserAddressScreen].
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: MagicAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MagicSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
              key: Key(controller.refreshData.value.toString()),
              future: controller.getAllUserAddresses(),
              builder: (context, snapshot) {
                final emptyWidget = Column(
                  children: [
                    SizedBox(height: MagicSizes.spaceBtwSections * 5),
                    MagicAnimationLoaderWidget(
                      text: 'No Addresses Saved',
                      animation: MagicImages.emptyAnimation,
                    ),
                  ],
                );
                final response =
                    MagicCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot,
                      nothingFound: emptyWidget,
                    );
                if (response != null) return response;

                final addresses = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  itemBuilder: (_, index) => MagicSingleAddress(
                    address: addresses[index],
                    onTap: () => controller.selectAddress(addresses[index]),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MagicColors.primary,
        onPressed: () => Get.to(() => AddNewAddressScreen()),
        child: Icon(Iconsax.add, color: MagicColors.white),
      ),
    );
  }
}
