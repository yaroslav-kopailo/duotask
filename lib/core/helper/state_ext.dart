import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

extension NavigationExt on State {
  void navigateNamed(String routeName) {
    context.router.root.navigateNamed(routeName);
  }

  void pushNamed(String routeName) {
    context.router.root.pushNamed(routeName);
  }

  void replaceNamed(String routeName) {
    context.router.root.replaceNamed(routeName);
  }
}
