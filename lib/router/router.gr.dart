// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:duotask/presentation/views/home_navigation_screen/home_navigation_screen.dart'
    as _i2;
import 'package:duotask/presentation/views/root_screen/root_screen.dart' as _i3;
import 'package:duotask/presentation/views/sign_in_screen/sign_in_screen.dart'
    as _i4;
import 'package:duotask/presentation/views/tasks_screen/tasks_screen.dart'
    as _i5;
import 'package:duotask/router/router.dart' as _i1;
import 'package:flutter/material.dart' as _i7;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    AuthRouter.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthRouterPage(),
      );
    },
    HomeNavigationRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeNavigationScreen(),
      );
    },
    RootRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.RootScreen(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SignInScreen(),
      );
    },
    TasksRoute.name: (routeData) {
      final args = routeData.argsAs<TasksRouteArgs>(
          orElse: () => const TasksRouteArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.TasksScreen(
          key: args.key,
          insertAnimationDuration: args.insertAnimationDuration,
          removeAnimationDuration: args.removeAnimationDuration,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthRouterPage]
class AuthRouter extends _i6.PageRouteInfo<void> {
  const AuthRouter({List<_i6.PageRouteInfo>? children})
      : super(
          AuthRouter.name,
          initialChildren: children,
        );

  static const String name = 'AuthRouter';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeNavigationScreen]
class HomeNavigationRoute extends _i6.PageRouteInfo<void> {
  const HomeNavigationRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeNavigationRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.RootScreen]
class RootRoute extends _i6.PageRouteInfo<void> {
  const RootRoute({List<_i6.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SignInScreen]
class SignInRoute extends _i6.PageRouteInfo<void> {
  const SignInRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.TasksScreen]
class TasksRoute extends _i6.PageRouteInfo<TasksRouteArgs> {
  TasksRoute({
    _i7.Key? key,
    Duration insertAnimationDuration = const Duration(milliseconds: 250),
    Duration removeAnimationDuration = const Duration(milliseconds: 250),
    List<_i6.PageRouteInfo>? children,
  }) : super(
          TasksRoute.name,
          args: TasksRouteArgs(
            key: key,
            insertAnimationDuration: insertAnimationDuration,
            removeAnimationDuration: removeAnimationDuration,
          ),
          initialChildren: children,
        );

  static const String name = 'TasksRoute';

  static const _i6.PageInfo<TasksRouteArgs> page =
      _i6.PageInfo<TasksRouteArgs>(name);
}

class TasksRouteArgs {
  const TasksRouteArgs({
    this.key,
    this.insertAnimationDuration = const Duration(milliseconds: 250),
    this.removeAnimationDuration = const Duration(milliseconds: 250),
  });

  final _i7.Key? key;

  final Duration insertAnimationDuration;

  final Duration removeAnimationDuration;

  @override
  String toString() {
    return 'TasksRouteArgs{key: $key, insertAnimationDuration: $insertAnimationDuration, removeAnimationDuration: $removeAnimationDuration}';
  }
}
