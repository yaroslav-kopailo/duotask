import 'package:duotask/core/style/app_theme.dart';
import 'package:duotask/presentation/base_widgets/icons/svg_icon.dart';
import 'package:flutter/material.dart';

class CustomToasts {
  static void showSecondaryToast({
    required BuildContext context,
    required String text,
    required String iconPath,
    required Color iconColor,
    Duration delayed = const Duration(milliseconds: 600),
  }) async {
    await Future.delayed(delayed);
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgIcon(
            iconPath: iconPath,
            color: iconColor,
            iconSize: 20,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: themeOf(context).toastOnSecondaryStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      backgroundColor: themeOf(context).secondaryActionColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(16),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
