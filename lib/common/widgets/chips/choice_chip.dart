import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';

class MagicChoiceChip extends StatelessWidget {
  const MagicChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = MagicHelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? SizedBox() : Text(text),
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
        labelPadding: isColor ? EdgeInsets.all(0) : null,
        // Center the icon
        padding: isColor ? EdgeInsets.all(0) : null,
        shape: isColor ? CircleBorder() : null,
        backgroundColor: isColor ? MagicHelperFunctions.getColor(text)! : null,
      ),
    );
  }
}
