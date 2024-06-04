import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandedScrollView extends StatelessWidget {
  const ExpandedScrollView({
    Key? key,
    required this.child,
    this.physics,
    this.hasScrollBody = false,
    this.controller,
  }) : super(key: key);

  final Widget child;
  final ScrollPhysics? physics;
  final bool hasScrollBody;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            controller: controller,
            shrinkWrap: true,
            physics: physics,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: hasScrollBody,
                child: child,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
