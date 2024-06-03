import 'package:duotask/core/style/app_theme.dart';
import 'package:flutter/material.dart';

///
class CElevatedButton extends StatelessWidget {
  const CElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
    this.backgroundColor = Colors.blueAccent,
    this.foregroundColor = Colors.white,
    this.disabledBackgroundColor = Colors.grey,
    this.disabledForegroundColor = Colors.white30,
    this.enabled = true,
    this.isLoading = false,
    this.width,
    this.height = 56,
    this.borderRadius = 10,
  });

  factory CElevatedButton.primaryActionLarge({
    Key? key,
    required BuildContext context,
    required Widget child,
    required VoidCallback onPressed,
    double height = 56,
    double? width,
    bool enabled = true,
    bool isLoading = false,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return CElevatedButton(
      key: key,
      onPressed: onPressed,
      height: height,
      width: width,
      padding: padding,
      borderRadius: 10,
      enabled: enabled,
      isLoading: isLoading,
      backgroundColor: themeOf(context).primaryActionColor,
      foregroundColor: themeOf(context).onPrimaryActionColor,
      disabledBackgroundColor: themeOf(context).primaryActionColor,
      disabledForegroundColor: themeOf(context).onPrimaryActionColor,
      child: child,
    );
  }

  factory CElevatedButton.paddingBased({
    Key? key,
    required Widget child,
    required VoidCallback onPressed,
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
    Color backgroundColor = Colors.deepPurpleAccent,
    Color foregroundColor = Colors.white,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    double borderRadius = 10,
    bool enabled = true,
    bool isLoading = false,
  }) {
    return CElevatedButton(
      key: key,
      onPressed: onPressed,
      height: 0,
      width: 0,
      padding: padding,
      borderRadius: borderRadius,
      enabled: enabled,
      isLoading: isLoading,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      disabledBackgroundColor:
          disabledBackgroundColor ?? backgroundColor.withOpacity(0.3),
      disabledForegroundColor: disabledForegroundColor ?? foregroundColor,
      child: child,
    );
  }

  factory CElevatedButton.sizeBased({
    Key? key,
    required Widget child,
    required VoidCallback onPressed,
    bool enabled = true,
    bool isLoading = false,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 20),
  }) {
    return CElevatedButton(
      key: key,
      onPressed: onPressed,
      height: 40,
      width: 160,
      padding: padding,
      borderRadius: 10,
      enabled: enabled,
      isLoading: isLoading,
      backgroundColor: Colors.blueAccent,
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
      return Size.fromWidth(width ?? 200);
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
  final Color backgroundColor;
  final Color foregroundColor;
  final Color disabledBackgroundColor;
  final Color disabledForegroundColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled && isLoading == false ? onPressed : null,
      style: ButtonStyle(
        splashFactory: InkSparkle.splashFactory,
        backgroundColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return disabledBackgroundColor;
          }
          return backgroundColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return disabledForegroundColor;
          }
          return foregroundColor;
        }),
        elevation: WidgetStateProperty.resolveWith<double>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.disabled)) {
            return 0;
          }
          return _defaultElevation;
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
        replacement: _CElevatedButtonLoader(
          size: (height ?? 56) / 2.5,
          foregroundColor: disabledForegroundColor,
        ),
        child: child,
      ),
    );
  }
}

///
class _CElevatedButtonLoader extends StatelessWidget {
  const _CElevatedButtonLoader({
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
        strokeWidth: 2,
      ),
    );
  }
}
