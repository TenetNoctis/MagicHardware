import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';

/// A custom choice chip that can display either text or a color.
class MagicChoiceChip extends StatelessWidget {
  /// Creates a [MagicChoiceChip].
  ///
  /// - [text]: The text to display in the chip. If the text represents a color,
  ///   a circular color swatch will be displayed instead.
  /// - [selected]: Whether the chip is currently selected.
  /// - [onSelected]: A callback function that is called when the chip is selected or deselected.
  const MagicChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  /// The text to display in the chip.
  final String text;

  /// Whether the chip is currently selected.
  final bool selected;

  /// A callback function that is called when the chip is selected or deselected.
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = MagicHelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? MagicColors.white : null),
        avatar: isColor
            ? MagicCircularContainer(
                width: 50,
                height: 50,
                backgroundColor: MagicHelperFunctions.getColor(text)!,
              )
            : null,
        labelPadding: isColor ? const EdgeInsets.all(0) : null,
        padding: isColor ? const EdgeInsets.all(0) : null,
        shape: isColor ? const CircleBorder() : null,
        backgroundColor: isColor ? MagicHelperFunctions.getColor(text)! : null,
      ),
    );
  }
}
