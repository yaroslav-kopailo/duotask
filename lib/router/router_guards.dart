import 'package:auto_route/auto_route.dart';
import 'package:duotask/core/helper/router_ext.dart';
import 'package:duotask/injection_container.dart';
import 'package:duotask/presentation/view_models/token_view_model.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    sl<TokenViewModel>().restoreAuthToken();

    if (sl<TokenViewModel>().isAuthorized.value) {
      resolver.next(true);
    } else {
      router.replaceAllToSignIn();
    }
  }
}
