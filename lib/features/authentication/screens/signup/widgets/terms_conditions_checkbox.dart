import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class MagicTermsAndConditionsCheckbox extends StatelessWidget {
  const MagicTermsAndConditionsCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(value: true, onChanged: (value) {}),
        ),
        const SizedBox(width: MagicSizes.spaceBtwItems),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: MagicTexts.iAgreeTo,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: ' ${MagicTexts.privacyPolicy}',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? MagicColors.white : MagicColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark
                      ? MagicColors.white
                      : MagicColors.primary,
                ),
              ),
              TextSpan(
                text: ' ${MagicTexts.and} ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: MagicTexts.termsOfUse,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? MagicColors.white : MagicColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark
                      ? MagicColors.white
                      : MagicColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
