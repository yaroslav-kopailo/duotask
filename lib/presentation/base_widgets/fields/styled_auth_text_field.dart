import 'package:duotask/core/helper/asset_paths.dart';
import 'package:duotask/core/style/app_theme.dart';
import 'package:duotask/core/style/input_decorations.dart';
import 'package:duotask/presentation/base_widgets/buttons/svg_icon_button.dart';
import 'package:duotask/presentation/base_widgets/icons/svg_icon.dart';
import 'package:flutter/material.dart';

class StyledAuthTextField extends StatefulWidget {
  const StyledAuthTextField({
    Key? key,
    required this.hintText,
    required this.onInput,
    this.style,
    this.controller,
    this.focusNode,
    this.hintStyle,
    this.isFieldCorrect = false,
    this.isPassword = false,
    this.isFieldFailed = false,
    this.failedDescription,
    this.onFieldInFocus,
  }) : super(key: key);

  final TextStyle? style;
  final String hintText;
  final TextStyle? hintStyle;
  final Function(String) onInput;
  final bool isFieldCorrect;
  final bool isFieldFailed;
  final String? failedDescription;
  final bool isPassword;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function()? onFieldInFocus;

  @override
  State<StyledAuthTextField> createState() => _StyledAuthTextFieldState();
}

class _StyledAuthTextFieldState extends State<StyledAuthTextField> {
  late final TextEditingController textController;
  late final FocusNode focusNode;
  bool hasFocus = false;
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    textController = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
    focusNode.addListener(changedFocusAction);
  }

  @override
  void dispose() {
    if (widget.controller == null) textController.dispose();
    if (widget.focusNode == null) focusNode.dispose();
    super.dispose();
  }

  void changedFocusAction() {
    setState(() {
      if (hasFocus != focusNode.hasFocus) hasFocus = focusNode.hasFocus;
    });
    if (hasFocus && widget.onFieldInFocus != null) {
      widget.onFieldInFocus!();
    }
  }

  void changeTextObscure() {
    setState(() {
      if (widget.isPassword) obscureText = !obscureText;
    });
  }

  TextStyle get dynamicTextStyle {
    // if (widget.isFieldFailed) {
    //   return ts.s13.w400.failed(context);
    // }
    return widget.style ?? themeOf(context).body1OnSurfaceStyle;
  }

  TextStyle get dynamicHintTextStyle {
    // if (widget.isFieldFailed) {
    //   return ts.s13.w400.failed(context);
    // }
    return widget.hintStyle ?? themeOf(context).hint1OnSurfaceStyle;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          onChanged: widget.onInput,
          controller: textController,
          focusNode: focusNode,
          obscureText: widget.isPassword && obscureText,
          style: dynamicTextStyle,
          decoration: CInputDecoration.authOutline(context,
                  isNotFailed: !widget.isFieldFailed)
              .copyWith(
            hintText: widget.hintText,
            hintStyle: dynamicHintTextStyle,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            suffixIconConstraints: const BoxConstraints(),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                runAlignment: WrapAlignment.center,
                spacing: 0,
                children: [
                  Visibility(
                    visible: widget.isPassword && !widget.isFieldFailed,
                    child: _EyeIconButton(
                      isVisible: obscureText == false,
                      onPressed: changeTextObscure,
                    ),
                  ),
                  Visibility(
                    visible: widget.isFieldCorrect && !widget.isFieldFailed,
                    child: SvgIcon(
                      iconPath: Assets.checkCorrectMark,
                      color: themeOf(context).greenSuccessColor,
                    ),
                  ),
                  Visibility(
                    visible: widget.isFieldFailed,
                    child: SvgIconButton(
                      iconPath: Assets.cancelCloseMultiplyCircle,
                      color: themeOf(context).redFailedColor,
                      withSplash: false,
                      onPressed: () => textController.clear(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: widget.failedDescription != null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.failedDescription ?? '',
                  style: themeOf(context).caption2RedFailedStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EyeIconButton extends StatelessWidget {
  const _EyeIconButton(
      {Key? key, required this.isVisible, required this.onPressed})
      : super(key: key);

  final bool isVisible;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SvgIconButton(
      iconPath:
          isVisible ? Assets.eyeViewRevealShowClosed : Assets.eyeViewRevealShow,
      onPressed: onPressed,
      withSplash: false,
    );
  }
}
