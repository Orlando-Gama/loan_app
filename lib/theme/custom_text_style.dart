import 'package:flutter/material.dart';
import 'package:tadza_loan/core/utils/size_utils.dart';
import 'package:tadza_loan/theme/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeGray700 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray700,
      );
  static get bodyLargeOnPrimaryContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get bodyLarge_1 => theme.textTheme.bodyLarge!;
  static get bodyLarge_2 => theme.textTheme.bodyLarge!;
  static get bodyLargeff292929 => theme.textTheme.bodyLarge!.copyWith(
        color: Color(0XFF292929),
      );
  static get bodyLargeff696969 => theme.textTheme.bodyLarge!.copyWith(
        color: Color(0XFF696969),
      );
  static get bodyMediumOnPrimaryContainer =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  // Headline text style
  static get headlineLargeOnPrimaryContainer =>
      theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  static get headlineMediumOnPrimaryContainer =>
      theme.textTheme.headlineMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
      );
  // Title text style
  static get titleMediumGray700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray700,
        fontSize: 16.fSize,
      );
  static get titleMediumGray900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray900,
        fontSize: 16.fSize,
      );
  static get titleMediumInterGray700 =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.gray700,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumInterGray700Medium =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.gray700,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumInterOnSecondaryContainer =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: theme.colorScheme.onSecondaryContainer,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumNunitoGray700 =>
      theme.textTheme.titleMedium!.nunito.copyWith(
        color: appTheme.gray700,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumOnSecondaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onSecondaryContainer,
        fontSize: 16.fSize,
      );
  static get titleMediumff151515 => theme.textTheme.titleMedium!.copyWith(
        color: Color(0XFF151515),
        fontSize: 16.fSize,
      );
  static get titleMediumff696969 => theme.textTheme.titleMedium!.copyWith(
        color: Color(0XFF696969),
        fontSize: 16.fSize,
      );
  static get titleMediumff9d9d9d => theme.textTheme.titleMedium!.copyWith(
        color: Color(0XFF9D9D9D),
        fontSize: 16.fSize,
      );
}

extension on TextStyle {
  TextStyle get hamon {
    return copyWith(
      fontFamily: 'Hamon',
    );
  }

  TextStyle get nunito {
    return copyWith(
      fontFamily: 'Nunito',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}
