import 'package:duotask/core/error/failures.dart';
import 'package:duotask/core/obs/observable_request.dart';
import 'package:duotask/core/style/app_theme.dart';
import 'package:duotask/presentation/base_widgets/buttons/custom_filled_button.dart';
import 'package:duotask/presentation/base_widgets/loading_widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class RetryRequestHandler extends StatefulWidget {
  const RetryRequestHandler({
    super.key,
    required this.request,
    required this.retryRequestAction,
    required this.child,
  });

  final ObservableRequest request;
  final Function() retryRequestAction;
  final Widget child;

  @override
  State<RetryRequestHandler> createState() => _RetryRequestHandlerState();
}

class _RetryRequestHandlerState extends State<RetryRequestHandler> {
  IconData? failureIconData;
  String? failureSubtitleText;

  void checkFailure(Failure failure) {
    if (context.mounted) {
      failureIconData = Icons.error_outline;
      failureSubtitleText = "Server Error! Please try your request again";
    }
  }

  void retryAction() {
    failureIconData = null;
    failureSubtitleText = null;
    widget.retryRequestAction();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (widget.request.isPending.value) {
        return const Center(
          child: LoaderWidget(),
        );
      }

      if (widget.request.isRejected.value) {
        checkFailure(widget.request.failure.value!);
        return Center(
          child: _RetryRequestWidget(
            retryAction: retryAction,
            iconData: failureIconData!,
            subtitleText: failureSubtitleText!,
          ),
        );
      }

      return widget.child;
    });
  }
}

class _RetryRequestWidget extends StatelessWidget {
  const _RetryRequestWidget({
    super.key,
    required this.iconData,
    required this.subtitleText,
    required this.retryAction,
  });

  final IconData iconData;
  final String subtitleText;
  final Function() retryAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconData, size: 40, color: themeOf(context).onBackgroundColor),
          const SizedBox(height: 18),
          Text(
            subtitleText,
            style: themeOf(context).body2OnBackgroundStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: CFilledButton.paddingBased(
                    backgroundColor: themeOf(context).secondaryActionColor,
                    foregroundColor: themeOf(context).onSecondaryActionColor,
                    onPressed: retryAction,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.refresh,
                          size: 20,
                          color: themeOf(context).onPrimaryActionColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Retry",
                          style: themeOf(context).buttonOnPrimaryActionStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
