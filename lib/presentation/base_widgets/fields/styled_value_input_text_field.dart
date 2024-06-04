import 'package:duotask/core/style/app_theme.dart';
import 'package:duotask/core/style/input_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StyledValueInputTextField extends StatefulWidget {
  const StyledValueInputTextField({
    Key? key,
    required this.hintText,
    required this.onInput,
    this.enabled = true,
    this.style,
    this.controller,
    this.focusNode,
    this.hintStyle,
    this.isFieldCorrect = false,
    this.isFieldFailed = false,
    this.failedDescription,
    this.onFieldInFocus,
    this.inputFormatters,
    this.keyboardType,
    this.value,
  }) : super(key: key);

  final bool enabled;
  final TextStyle? style;
  final String hintText;
  final String? value;
  final TextStyle? hintStyle;
  final Function(String) onInput;
  final bool isFieldCorrect;
  final bool isFieldFailed;
  final String? failedDescription;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function()? onFieldInFocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  @override
  State<StyledValueInputTextField> createState() =>
      _StyledValueInputTextFieldState();
}

class _StyledValueInputTextFieldState extends State<StyledValueInputTextField> {
  late final TextEditingController textController;
  late final FocusNode focusNode;
  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    textController = widget.controller ?? TextEditingController();
    if (widget.value != null) textController.text = widget.value!;
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
    if (mounted == false) return;
    setState(() {
      if (hasFocus != focusNode.hasFocus) hasFocus = focusNode.hasFocus;
    });
    if (hasFocus && widget.onFieldInFocus != null) {
      widget.onFieldInFocus!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          enabled: widget.enabled,
          onChanged: widget.onInput,
          controller: textController,
          focusNode: focusNode,
          style: widget.style ?? themeOf(context).body1OnSurfaceStyle,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          decoration: CInputDecoration.valueInputOutline(context,
                  isNotFailed: !widget.isFieldFailed)
              .copyWith(
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ?? themeOf(context).hint1OnSurfaceStyle,
            contentPadding: const EdgeInsets.all(16),
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
