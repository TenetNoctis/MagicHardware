import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';

/// A widget that displays a rating progress indicator.
///
/// This widget consists of a text label and a linear progress indicator.
class MagicRatingProgressIndicator extends StatelessWidget {
  /// Creates a [MagicRatingProgressIndicator].
  ///
  /// The [text] and [value] parameters are required.
  const MagicRatingProgressIndicator({
    super.key,
    required this.text,
    required this.value,
  });

  /// The text to display next to the progress indicator.
  final String text;

  /// The value of the progress indicator, from 0.0 to 1.0.
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: MagicDeviceUtils.getScreenWidth(context) * 0.5,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 11,
              backgroundColor: MagicColors.grey,
              valueColor: const AlwaysStoppedAnimation(MagicColors.primary),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
      ],
    );
  }
}
