import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';

/// A class that defines custom spacing and padding styles for the application.
class MagicSpacingStyle {
  /// The padding with app bar height.
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: MagicSizes.appBarHeight,
    left: MagicSizes.defaultSpace,
    right: MagicSizes.defaultSpace,
    bottom: MagicSizes.defaultSpace,
  );
}
