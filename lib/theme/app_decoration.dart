import 'package:flutter/material.dart';
import 'package:tadza_loan/core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillOnError => BoxDecoration(
        color: theme.colorScheme.onError,
      );
}

class BorderRadiusStyle {
  // Custom borders
  static BorderRadius get customBorderTL24 => BorderRadius.only(
        topLeft: Radius.circular(24.h),
        topRight: Radius.circular(23.h),
        bottomLeft: Radius.circular(24.h),
        bottomRight: Radius.circular(23.h),
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
