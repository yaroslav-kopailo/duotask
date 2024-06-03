import 'package:auto_route/auto_route.dart';
import 'package:duotask/router/router.gr.dart';

extension StackRouterExt on StackRouter {
  Future<void> replaceAllToSignIn() async {
    await root.replaceAll(
      [const SignInRoute()],
      updateExistingRoutes: false,
    );
  }
}
