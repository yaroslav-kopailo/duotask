import 'package:duotask/presentation/base_widgets/icons/svg_icon.dart';
import 'package:flutter/material.dart';

class CircleSvgIcon extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final Color foregroundColor;
  final double padding;
  final String iconPath;

  const CircleSvgIcon({
    Key? key,
    required this.size,
    required this.backgroundColor,
    required this.foregroundColor,
    this.padding = 0,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgIcon(
          iconPath: iconPath,
          iconSize: size,
          color: foregroundColor,
        ),
      ),
    );
  }
}
