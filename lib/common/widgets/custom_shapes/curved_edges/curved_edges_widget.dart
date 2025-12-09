import 'package:flutter/material.dart';

import 'curved_edges.dart';

/// A widget that clips its child in a custom curved shape.
class MagicCurvedEdgeWidget extends StatelessWidget {
  /// Creates a curved edge widget.
  ///
  /// The [child] parameter is the widget to be clipped.
  const MagicCurvedEdgeWidget({super.key, this.child});

  /// The widget below this widget in the tree.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: MagicCustomCurvedEdges(), child: child);
  }
}
