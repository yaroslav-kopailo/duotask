import 'package:auto_route/auto_route.dart';
import 'package:duotask/router/router.gr.dart';
import 'package:duotask/router/router_guards.dart';

@RoutePage(name: 'AuthRouter')
class AuthRouterPage extends AutoRouter {
  const AuthRouterPage({super.key});
}

/// Generate router code
/// dart run build_runner watch --delete-conflicting-outputs
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  static final List<AutoRouteGuard> authGuards = [AuthGuard()];

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/',
      page: RootRoute.page,
      children: [
        RedirectRoute(path: '', redirectTo: 'tasks'),
        AutoRoute(
          path: '',
          page: AuthRouter.page,
          children: [
            RedirectRoute(path: '', redirectTo: 'sign-in'),
            AutoRoute(path: 'sign-in', page: SignInRoute.page),
          ],
        ),
        AutoRoute(
          path: '',
          page: HomeNavigationRoute.page,
          guards: authGuards,
          children: [
            AutoRoute(path: 'tasks', page: TasksRoute.page),
          ],
        ),
      ],
    ),
  ];
}
