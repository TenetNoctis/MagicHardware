import 'package:flutter/material.dart';
import 'package:magic_hardware/utils/constants/colors.dart';

/// A settings menu tile widget that displays an icon, title, subtitle, and an optional trailing widget.
class MagicSettingsMenuTile extends StatelessWidget {
  /// Creates a settings menu tile.
  const MagicSettingsMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  /// The icon to display on the left side of the tile.
  final IconData icon;

  /// The title of the settings option.
  final String title;

  /// The subtitle of the settings option.
  final String subtitle;

  /// An optional widget to display on the right side of the tile.
  final Widget? trailing;

  /// A callback to be executed when the tile is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28, color: MagicColors.primary),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.labelMedium),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
