import 'package:flutter/material.dart';

/// A widget for displaying a section heading with an optional action button.
class MagicSectionHeading extends StatelessWidget {
  /// Creates a [MagicSectionHeading] widget.
  const MagicSectionHeading({
    super.key,
    this.onPressed,
    this.textColor,
    this.buttonTitle = 'View all',
    required this.title,
    this.showActionButton = true,
  });

  /// The color of the heading text.
  final Color? textColor;

  /// Whether to show the action button.
  final bool showActionButton;

  /// The title of the section.
  final String title;

  /// The text to display on the action button.
  final String buttonTitle;

  /// The callback function to be executed when the action button is pressed.
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(onPressed: onPressed, child: Text(buttonTitle)),
      ],
    );
  }
}
