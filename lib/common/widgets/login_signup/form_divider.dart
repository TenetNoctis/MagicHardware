import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';

/// A widget that displays a divider with text in the middle.
class MagicFormDivider extends StatelessWidget {
  /// Creates a form divider.
  ///
  /// The [dividerText] is the text to be displayed in the middle of the divider.
  const MagicFormDivider({super.key, required this.dividerText});

  /// The text to be displayed in the middle of the divider.
  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: dark ? MagicColors.darkGrey : MagicColors.grey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(
          dividerText.capitalize!,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            color: dark ? MagicColors.darkGrey : MagicColors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
