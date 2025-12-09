import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

/// A widget that displays the login screen's header, including the app logo and titles.
class MagicLoginHeader extends StatelessWidget {
  /// Creates a [MagicLoginHeader].
  ///
  /// The [dark] parameter determines which app logo to display.
  const MagicLoginHeader({super.key, required this.dark});

  /// Whether the current theme is dark or not.
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 100,
          image: AssetImage(
            dark ? MagicImages.darkAppIcon : MagicImages.lightAppIcon,
          ),
        ),
        Text(
          MagicTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: MagicSizes.sm),
        Text(
          MagicTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
