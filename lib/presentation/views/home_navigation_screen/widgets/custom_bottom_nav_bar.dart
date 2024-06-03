import 'package:duotask/core/helper/asset_paths.dart';
import 'package:duotask/core/style/app_theme.dart';
import 'package:duotask/presentation/base_widgets/buttons/custom_elevated_button.dart';
import 'package:duotask/presentation/base_widgets/icons/svg_icon.dart';
import 'package:flutter/material.dart';

class CBottomNavBar extends StatelessWidget {
  const CBottomNavBar({
    Key? key,
    required this.onTabSelected,
    required this.onAddTaskPressed,
  }) : super(key: key);

  final Function(int) onTabSelected;
  final VoidCallback onAddTaskPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 98.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: themeOf(context).surfaceContainerHighestColor,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 14.0, spreadRadius: 0),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Assets.home, 0),
          _buildNavItem(context, Assets.calendar, 1),
          _buildAddButton(context),
          _buildNavItem(context, Assets.chat, 3),
          _buildNavItem(context, Assets.user, 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String assetPath, int index) {
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgIcon(
            iconPath: assetPath,
            iconSize: 24,
            color: Colors.grey,
          ),
          const SizedBox(height: 8.0),
          if (index == 0)
            Container(
              height: 3,
              width: 40,
              color: themeOf(context).onSurfaceColor,
            ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return CElevatedButton.paddingBased(
      onPressed: onAddTaskPressed,
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 22),
      backgroundColor: themeOf(context).primaryActionColor,
      foregroundColor: themeOf(context).onPrimaryActionColor,
      child: SvgIcon(
        iconPath: Assets.add,
        color: themeOf(context).onPrimaryActionColor,
      ),
    );
  }
}
