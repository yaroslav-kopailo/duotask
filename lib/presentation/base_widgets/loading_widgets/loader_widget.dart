import 'package:duotask/core/style/app_theme.dart';
import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({
    super.key,
    this.valueColor,
    this.backgroundColor,
    this.strokeWidth = 3,
    this.size = 36,
  });

  final Color? valueColor;
  final Color? backgroundColor;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        backgroundColor: backgroundColor ?? Colors.transparent,
        valueColor: AlwaysStoppedAnimation<Color>(
          valueColor ?? themeOf(context).onBackgroundColor,
        ),
        strokeWidth: strokeWidth,
      ),
    );
  }
}
