import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({
    super.key,
    required this.color,
    required this.iconPath,
    this.iconSize = 24,
  });

  final String iconPath;
  final double iconSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      height: iconSize,
      width: iconSize,
      fit: BoxFit.fill,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
