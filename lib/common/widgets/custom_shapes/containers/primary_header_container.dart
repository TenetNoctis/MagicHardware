import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_container.dart';

/// A widget that displays a primary header container with a curved edge.
///
/// This widget is composed of a `MagicCurvedEdgeWidget` and a `Container` with a primary color.
/// It also includes two `MagicCircularContainer` widgets positioned to create a decorative effect.
class MagicPrimaryHeaderContainer extends StatelessWidget {
  /// Creates a primary header container.
  ///
  /// The [child] parameter is required and will be displayed on top of the container.
  const MagicPrimaryHeaderContainer({super.key, required this.child});

  /// The widget to display on top of the container.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MagicCurvedEdgeWidget(
      child: Container(
        color: MagicColors.primary,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: MagicCircularContainer(
                  backgroundColor: MagicColors.textWhite.withValues(alpha: 0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: MagicCircularContainer(
                  backgroundColor: MagicColors.textWhite.withValues(alpha: 0.1),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
