import 'package:flutter/material.dart';
import '../../utils/constants/sizes.dart';

class MagicSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: MagicSizes.appBarHeight,
    left: MagicSizes.defaultSpace,
    right: MagicSizes.defaultSpace,
    bottom: MagicSizes.defaultSpace,
  );
}