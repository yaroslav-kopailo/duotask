import 'package:flutter/material.dart';

///
class COutlinedButton extends StatelessWidget {
  const COutlinedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
    this.outlinedColor = Colors.blueAccent,
    this.foregroundColor = Colors.white,
    this.disabledOutlinedColor = Colors.grey,
    this.disabledForegroundColor = Colors.white30,
    this.enabled = true,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = 56,
    this.borderRadius = 10,
  });

  factory COutlinedButton.paddingBased({
    Key? key,
    required Widget child,
    required VoidCallback onPressed,
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
    Color outlinedColor = Colors.deepPurpleAccent,
    Color foregroundColor = Colors.white,
    Color? disabledOutlinedColor,
    Color? disabledForegroundColor,
    double borderRadius = 10,
    bool enabled = true,
    bool isLoading = false,
  }) {
    return COutlinedButton(
      key: key,
      onPressed: onPressed,
      height: 0,
      width: 0,
      padding: padding,
      borderRadius: borderRadius,
      enabled: enabled,
      isLoading: isLoading,
      outlinedColor: outlinedColor,
      foregroundColor: foregroundColor,
      disabledForegroundColor:
          disabledOutlinedColor ?? outlinedColor.withOpacity(0.3),
      disabledOutlinedColor: disabledForegroundColor ?? foregroundColor,
      child: child,
    );
  }

  factory COutlinedButton.sizeBased({
    Key? key,
    required Widget child,
    required VoidCallback onPressed,
    double height = 56,
    double? width,
    bool enabled = true,
    bool isLoading = false,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20),
  }) {
    return COutlinedButton(
      key: key,
      onPressed: onPressed,
      height: height,
      width: width,
      padding: padding,
      borderRadius: 10,
      enabled: enabled,
      isLoading: isLoading,
      outlinedColor: Colors.blueAccent,
      foregroundColor: Colors.white,
      child: child,
    );
  }

  Size get minSize {
    if (width != null && height != null) {
      return Size(width!, height!);
    } //
    else if (height != null) {
      return Size.fromHeight(height!);
    } //
    else {
      return Size.fromWidth(width!);
    }
  }

  static const _defaultElevation = 3.0;
  final Widget child;
  final VoidCallback onPressed;
  final bool enabled;
  final bool isLoading;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final Color outlinedColor;
  final Color foregroundColor;
  final Color disabledForegroundColor;
  final Color disabledOutlinedColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: enabled && isLoading == false ? onPressed : null,
      style: ButtonStyle(
        splashFactory: InkSparkle.splashFactory,
        side: WidgetStateProperty.resolveWith<BorderSide>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(color: disabledOutlinedColor);
            }
            return BorderSide(color: outlinedColor);
          },
        ),
        elevation: WidgetStateProperty.resolveWith<double>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.disabled)) {
            return 0;
          }
          return _defaultElevation;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return disabledForegroundColor;
          }
          return foregroundColor;
        }),
        // shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
        // overlayColor: WidgetStateProperty.all<Color>(overlayColor),
        minimumSize: WidgetStateProperty.all<Size>(minSize),
        maximumSize: WidgetStateProperty.all<Size>(Size.infinite),
        padding: WidgetStateProperty.all<EdgeInsets>(padding),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      child: Visibility(
        visible: isLoading == false,
        replacement: _COutlinedButtonLoader(
          size: (height ?? 56) / 2.5,
          foregroundColor: disabledOutlinedColor,
        ),
        child: child,
      ),
    );
  }
}

///
class _COutlinedButtonLoader extends StatelessWidget {
  const _COutlinedButtonLoader({
    super.key,
    required this.size,
    required this.foregroundColor,
    this.backgroundColor = Colors.transparent,
  });

  final Color foregroundColor;
  final Color backgroundColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(
          foregroundColor,
        ),
        strokeWidth: 3,
      ),
    );
  }
}
