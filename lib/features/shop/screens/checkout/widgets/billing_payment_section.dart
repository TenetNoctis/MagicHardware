import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/image_strings.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

class MagicBillingPaymentSection extends StatelessWidget {
  const MagicBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        MagicSectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: (){}),
        const SizedBox(height: MagicSizes.spaceBtwItems / 2),
        Row(
          children: [
            MagicRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? MagicColors.light : MagicColors.white,
              padding:EdgeInsets.all(MagicSizes.sm),
              child: Image(image: AssetImage(MagicImages.paypal), fit: BoxFit.contain,),
            ),
            const SizedBox(width: MagicSizes.spaceBtwItems / 2),
            Text('Paypal', style: Theme.of(context).textTheme.bodyLarge,)
          ],
        )
      ],
    );
  }
}
