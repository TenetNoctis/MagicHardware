import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

/// A reusable profile menu item widget.
class MagicProfileMenu extends StatelessWidget {
  /// Creates a [MagicProfileMenu] widget.
  const MagicProfileMenu({
    super.key,
    this.icon = Iconsax.add2,
    required this.onPressed,
    required this.title,
    required this.value,
  });

  /// The icon to be displayed.
  final IconData icon;

  /// The callback function to be executed when the widget is tapped.
  final VoidCallback onPressed;

  /// The title of the menu item.
  final String title;

  /// The value of the menu item.
  final String value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: MagicSizes.spaceBtwItems / 1.5,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(child: Icon(icon, size: 18)),
          ],
        ),
      ),
    );
  }
}
