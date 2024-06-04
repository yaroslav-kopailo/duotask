import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// The root screen of the application, serving as an entry point for the routing system.
///
/// This class defines the root widget for the application's route hierarchy. It is designed
/// to interact with the AutoRoute package to manage navigation and route definitions.
@RoutePage()
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => RootScreenState();
}

class RootScreenState extends State<RootScreen> {
  bool isProcessing = false;

  /// Provides a way to access the RootScreenState from the widget tree.
  static RootScreenState of(BuildContext context) {
    return context.findAncestorStateOfType<RootScreenState>()!;
  }

  /// Shows a bottom sheet with customizable behavior and appearance.
  Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required Widget bottomSheet,
    VoidCallback? onDismiss,
    bool isDismissible = false,
    bool enableDrag = false,
    bool useRootNavigator = true,
  }) async {
    final orientation = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;
    return await showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      useSafeArea: true,
      isScrollControlled: true,
      enableDrag: enableDrag,
      constraints: BoxConstraints(
        maxWidth: size.width > 650 && orientation == Orientation.landscape
            ? 650
            : size.width,
      ),
      builder: (context) {
        return PopScope(
          canPop: isDismissible,
          child: bottomSheet,
          onPopInvoked: (didPop) {
            if (didPop) {
              if (onDismiss != null) onDismiss();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
