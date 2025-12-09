import 'package:flutter/material.dart';

/// A custom clipper that creates a path with curved edges at the bottom.
class MagicCustomCurvedEdges extends CustomClipper<Path> {
  /// Returns a `Path` that clips the widget in a custom shape.
  /// The path creates a container with a curved bottom edge.
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    // Defines the first curve at the bottom left.
    final firstCurve = Offset(0, size.height - 20);
    final lastCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(
      firstCurve.dx,
      firstCurve.dy,
      lastCurve.dx,
      lastCurve.dy,
    );

    // A straight line across the bottom.
    path.lineTo(size.width - 30, size.height - 20);

    // Defines the second curve at the bottom right.
    final thirdFirstCurve = Offset(size.width, size.height - 20);
    final thirdLastCurve = Offset(size.width, size.height);
    path.quadraticBezierTo(
      thirdFirstCurve.dx,
      thirdFirstCurve.dy,
      thirdLastCurve.dx,
      thirdLastCurve.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  /// Determines whether the clipper should reclip when the instance changes.
  /// Returning true here ensures that the clip is updated when the widget rebuilds.
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
