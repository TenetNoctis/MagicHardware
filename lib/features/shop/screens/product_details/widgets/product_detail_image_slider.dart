import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/magic_circular_icon.dart';
import '../../../../../common/widgets/images/magic_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class MagicProductImageSlider extends StatelessWidget {
  const MagicProductImageSlider({super.key,});


  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return MagicCurvedEdgeWidget(
      child: Container(
        color: dark ? MagicColors.darkerGrey : MagicColors.light,
        child: Stack(
          children: [
            // Main Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(MagicSizes.productImageRadius * 3),
                child: Center(
                  child: Image(image: AssetImage(MagicImages.weldingGlove)),
                ),
              ),
            ),

            // Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: MagicSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (_, _) =>
                      SizedBox(width: MagicSizes.spaceBtwItems),
                  itemCount: 6,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => MagicRoundedImage(
                    width: 80,
                    backgroundColor: dark
                        ? MagicColors.darkestGrey
                        : MagicColors.white,
                    border: Border.all(color: MagicColors.primary),
                    padding: const EdgeInsets.all(MagicSizes.sm),
                    imageUrl: MagicImages.weldingGlove,
                  ),
                ),
              ),
            ),

            // Appbar Icons
            MagicAppBar(
              showBackArrow: true,
              actions: [
                MagicCircularIcon(icon: Iconsax.heart5, color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
