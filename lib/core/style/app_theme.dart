import 'package:duotask/core/style/typography.dart';
import 'package:flutter/material.dart';
import 'package:themexpert/themexpert.dart';

T themeOf<T extends AppTheme>(BuildContext context) {
  return ThemeX.ofType<T>(context);
}

class AppTheme extends BaseTheme {
  const AppTheme(super.context);

  LinearGradient get primaryActionGradient => const LinearGradient(
        begin: Alignment(0.00, -1.00),
        end: Alignment(0, 1),
        colors: [Color(0xFFBFB6FA), Color(0xFFF4F3FF)],
      );

  Color get primaryActionColor => const Color(0xff2196F3);

  Color get onPrimaryActionColor => const Color(0xffffffff);

  Color get secondaryActionColor => const Color(0xff3B3A63);

  Color get onSecondaryActionColor => const Color(0xffF6F8F9);

  Color get backgroundColor => const Color(0xffffffff);

  Color get onBackgroundColor => const Color(0xFF3B3A63);

  Color get surfaceContainerColor => const Color(0xffF3F3F6);

  Color get surfaceContainerLowestColor => const Color(0xffF3F3F6);

  Color get surfaceContainerHighestColor => const Color(0xffffffff);

  Color get onSurfaceColor => const Color(0xFF3B3A63);

  Color get outlineColor => const Color(0xFF3B3A63).withOpacity(0.3);

  Color get dividerColor => const Color(0xffC4C4D0);

  Color get redAccentColor => const Color(0xffEC1A1A);

  Color get greenAccentColor => const Color(0xff32B73F);

  Color get orangeAccentColor => const Color(0xffF59D1A);

  Color get blueAccentColor => const Color(0xff45BDCD);

  Color get onAccentColor => const Color(0xffffffff);

  Color get greenSuccessColor => const Color(0xff47D16C);

  Color get redFailedColor => const Color(0xffEC1A1A);

  TextStyle get h4OnBackgroundStyle => RobotoTypography.h4.copyWith(
        color: onBackgroundColor,
      );

  TextStyle get h6OnBackgroundStyle => RobotoTypography.h6.copyWith(
        color: onBackgroundColor,
      );

  TextStyle h6OnBackgroundStyleWithOpacity([double opacity = 1]) =>
      h6OnBackgroundStyle.copyWith(
        color: onBackgroundColor.withOpacity(opacity),
      );

  TextStyle get subtitle2OnSurfaceStyle => RobotoTypography.subtitle2.copyWith(
        color: onSurfaceColor,
      );

  TextStyle get body1OnBackgroundStyle => RobotoTypography.body1.copyWith(
        color: onBackgroundColor,
        fontWeight: FontWeight.w400,
      );

  TextStyle get body2OnSurfaceStyle => RobotoTypography.body2.copyWith(
        color: onSurfaceColor,
      );

  TextStyle get body2OnBackgroundStyle => RobotoTypography.body2.copyWith(
        color: onBackgroundColor,
      );

  TextStyle body2OnSurfaceStyleWithOpacity([double opacity = 1]) =>
      RobotoTypography.body2.copyWith(
        color: onSurfaceColor.withOpacity(opacity),
      );

  TextStyle get hint2OnSurfaceStyle => RobotoTypography.body2.copyWith(
        color: onSurfaceColor.withOpacity(0.6),
      );

  TextStyle get buttonOnPrimaryActionStyle => RobotoTypography.button.copyWith(
        color: onPrimaryActionColor,
      );

  TextStyle get caption1OnAccentStyle => RobotoTypography.caption1.copyWith(
        color: onAccentColor,
        fontWeight: FontWeight.w600,
      );

  TextStyle get caption2RedFailedStyle => RobotoTypography.caption2.copyWith(
        color: redFailedColor,
      );

  TextStyle get toastOnSecondaryStyle => RobotoTypography.toast.copyWith(
        color: onSecondaryActionColor,
      );
}
