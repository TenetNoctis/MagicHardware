import 'package:flutter/material.dart';

import 'curved_edges.dart';

class MagicCurvedEdgeWidget extends StatelessWidget {
  const MagicCurvedEdgeWidget({
    super.key, this.child,
  });

  final Widget? child;


  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MagicCustomCurvedEdges() ,
      child: child,
    );
  }
}