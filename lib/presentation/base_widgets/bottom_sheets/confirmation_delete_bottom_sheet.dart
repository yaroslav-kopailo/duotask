import 'package:duotask/core/style/app_theme.dart';
import 'package:duotask/presentation/base_widgets/bottom_sheets/bottom_sheet_body.dart';
import 'package:duotask/presentation/base_widgets/buttons/custom_elevated_button.dart';
import 'package:duotask/presentation/base_widgets/buttons/custom_outlined_button.dart';
import 'package:flutter/material.dart';

class ConfirmationDeleteBottomSheet extends StatelessWidget {
  ConfirmationDeleteBottomSheet(
      {super.key, required this.onConfirm, required this.onCancel});

  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBody(
      borderRadiusValue: 10,
      contentPadding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Are you sure you want to delete this task?',
              style: themeOf(context).h5OnSurfaceStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: COutlinedButton(
                  onPressed: () {
                    onCancel();
                    Navigator.of(context).pop();
                  },
                  outlinedColor: themeOf(context).outlineAlternateColor,
                  foregroundColor: themeOf(context).onSurfaceAlternateColor,
                  height: 50,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'CANCEL',
                    style: themeOf(context).buttonOnSurfaceAlternateStyle,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CElevatedButton(
                  onPressed: () {
                    onConfirm();
                    Navigator.of(context).pop();
                  },
                  backgroundColor: themeOf(context).redAccentColor,
                  foregroundColor: themeOf(context).onAccentColor,
                  height: 50,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'YES',
                    style: themeOf(context).buttonOnAccentStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
