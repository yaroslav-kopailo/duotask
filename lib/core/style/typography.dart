import 'package:flutter/material.dart';

class RobotoTypography {
  static const String _baseFont = 'Roboto';

  static const _textStyle = TextStyle(fontFamily: _baseFont);

  static final h1 = _textStyle.copyWith(
    fontWeight: FontWeight.w300,
    fontSize: 32,
    letterSpacing: -1.5,
  );

  static final h2 = _textStyle.copyWith(
    fontWeight: FontWeight.w300,
    fontSize: 60,
    letterSpacing: -0.5,
  );

  static final h3 = _textStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 48,
    letterSpacing: 0,
  );

  static final h4 = _textStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 32,
    letterSpacing: 0.5,
  );

  static final TextStyle h5 = _textStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    letterSpacing: 0.5,
  );

  static final TextStyle h6 = _textStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    letterSpacing: 0.5,
  );

  static final TextStyle subtitle1 = _textStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.15,
  );

  static final TextStyle subtitle2 = _textStyle.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    letterSpacing: 0.5,
  );

  static final TextStyle body1 = _textStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.5,
  );

  static final TextStyle body2 = _textStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.5,
  );

  static final button = _textStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 15,
    letterSpacing: 0.46,
  );

  static final TextStyle caption1 = _textStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.5,
  );

  static final TextStyle caption2 = _textStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 10,
    letterSpacing: 0.5,
  );

  static final TextStyle toast = _textStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.5,
  );

  static final overLine = _textStyle.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 10,
    letterSpacing: 1.5,
  );
}
