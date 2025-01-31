import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class BottomSheetBody extends StatelessWidget {
  const BottomSheetBody({
    super.key,
    this.contentPadding = const EdgeInsets.fromLTRB(16, 20, 16, 16),
    this.borderRadiusValue = 40,
    required this.child,
  });

  final Widget child;
  final EdgeInsetsGeometry contentPadding;
  final double borderRadiusValue;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(
            16,
            0,
            16,
            24 + MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: contentPadding,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
          child: child,
        ),
      ),
    );
  }
}
