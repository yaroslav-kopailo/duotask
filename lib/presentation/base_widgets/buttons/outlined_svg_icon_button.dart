import 'package:duotask/presentation/base_widgets/icons/svg_icon.dart';
import 'package:flutter/material.dart';

class OutlinedSvgIconButton extends StatelessWidget {
  final Color color;
  final String iconPath;
  final double iconSize;
  final double borderRadius;
  final double padding;
  final double borderWidth;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;

  const OutlinedSvgIconButton({
    Key? key,
    required this.color,
    required this.iconPath,
    this.onPressed,
    this.padding = 14,
    this.borderWidth = 1,
    this.iconSize = 24,
    this.borderRadius = 10,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(padding),
          side: BorderSide(color: color, width: borderWidth),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: SvgIcon(
          iconPath: iconPath,
          iconSize: iconSize,
          color: color,
        ),
      ),
    );
  }
}
