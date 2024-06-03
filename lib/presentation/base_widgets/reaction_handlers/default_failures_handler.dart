import 'package:duotask/core/error/failures.dart';
import 'package:duotask/core/helper/asset_paths.dart';
import 'package:duotask/core/style/app_theme.dart';
import 'package:duotask/presentation/base_widgets/toasts/custom_toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class DefaultFailuresHandler extends StatefulWidget {
  const DefaultFailuresHandler(
      {super.key, required this.child, this.failures = const []});

  final Widget child;
  final List<Computed<Failure?>> failures;

  @override
  State<DefaultFailuresHandler> createState() => _DefaultFailuresHandlerState();
}

class _DefaultFailuresHandlerState extends State<DefaultFailuresHandler> {
  void onFailure(Failure? failure) {
    if (failure is ServerFailure) {
      CustomToasts.showSecondaryToast(
        context: context,
        text: failure.userMessage,
        iconPath: Assets.closeCircle,
        iconColor: themeOf(context).redAccentColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiReactionBuilder(
      builders: widget.failures
          .map((failure) => ReactionBuilder(
                builder: (context) {
                  return reaction(
                    (_) => failure.value,
                    onFailure,
                  );
                },
              ))
          .toList(),
      child: widget.child,
    );
  }
}
