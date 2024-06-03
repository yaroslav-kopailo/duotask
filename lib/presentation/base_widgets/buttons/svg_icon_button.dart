import 'package:duotask/core/style/app_theme.dart';
import 'package:duotask/presentation/base_widgets/icons/svg_icon.dart';
import 'package:flutter/material.dart';

class SvgIconButton extends StatelessWidget {
  const SvgIconButton({
    Key? key,
    required this.iconPath,
    required this.onPressed,
    this.iconSize = 24,
    this.color,
    this.withSplash = false,
    this.splashColor,
    this.splashRadius = 20,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final String iconPath;
  final double iconSize;
  final Color? color;
  final Function() onPressed;
  final bool withSplash;
  final Color? splashColor;
  final double splashRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: iconSize + padding.vertical,
        maxWidth: iconSize + padding.horizontal,
      ),
      child: IconButton(
        onPressed: onPressed,
        padding: padding,
        splashColor: withSplash ? splashColor : Colors.transparent,
        highlightColor: withSplash ? splashColor : Colors.transparent,
        splashRadius: splashRadius,
        icon: SvgIcon(
          iconPath: iconPath,
          iconSize: iconSize,
          color: color ?? themeOf(context).onSurfaceColor,
        ),
      ),
    );
  }
}
