import 'package:duotask/core/style/app_theme.dart';
import 'package:flutter/material.dart';

abstract class CInputDecoration {
  static InputDecoration authOutline(BuildContext context,
          {bool isNotFailed = true}) =>
      InputDecoration(
        fillColor: themeOf(context).surfaceContainerHighestColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: isNotFailed
                ? themeOf(context).outlineColor
                : themeOf(context).redFailedColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: isNotFailed
                ? themeOf(context).outlineColor
                : themeOf(context).redFailedColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: isNotFailed
                ? themeOf(context).outlineColor
                : themeOf(context).redFailedColor,
          ),
        ),
      );

  static InputDecoration valueInputOutline(BuildContext context,
          {bool isNotFailed = true}) =>
      InputDecoration(
        fillColor: themeOf(context).surfaceContainerHighestColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: isNotFailed
                ? themeOf(context).outlineColor
                : themeOf(context).redFailedColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: isNotFailed
                ? themeOf(context).outlineColor
                : themeOf(context).redFailedColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: isNotFailed
                ? themeOf(context).outlineColor
                : themeOf(context).redFailedColor,
          ),
        ),
      );
}
