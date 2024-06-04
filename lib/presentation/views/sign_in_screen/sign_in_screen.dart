import 'package:auto_route/auto_route.dart';
import 'package:duotask/core/helper/asset_paths.dart';
import 'package:duotask/core/helper/state_ext.dart';
import 'package:duotask/core/style/app_theme.dart';
import 'package:duotask/core/util/keyboard_tool.dart';
import 'package:duotask/injection_container.dart';
import 'package:duotask/presentation/base_widgets/buttons/custom_elevated_button.dart';
import 'package:duotask/presentation/base_widgets/fields/styled_auth_text_field.dart';
import 'package:duotask/presentation/base_widgets/reaction_handlers/default_failures_handler.dart';
import 'package:duotask/presentation/base_widgets/scroll_widgets/expanded_scroll_view.dart';
import 'package:duotask/presentation/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _authViewModel = sl<AuthViewModel>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void signIn() async {
    KeyboardTool.hideKeyboard(context);
    await _authViewModel.executeSignIn();
  }

  void navigateToHome() async {
    replaceNamed('tasks');
  }

  @override
  Widget build(BuildContext context) {
    return Provider<AuthViewModel>(
      create: (_) => _authViewModel,
      child: MultiReactionBuilder(
        builders: [
          ReactionBuilder(
            builder: (context) {
              return reaction(
                (_) => _authViewModel.successSignIn.value,
                (_) => navigateToHome(),
              );
            },
          )
        ],
        child: DefaultFailuresHandler(
          failures: [_authViewModel.requestSignIn.failure],
          child: KeyboardDismissOnTap(
            child: Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ExpandedScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Text(
                          'Sign In',
                          textAlign: TextAlign.center,
                          style: themeOf(context).h4OnBackgroundStyle,
                        ),
                        const SizedBox(height: 40),
                        _RxEmailSignInField(
                          onInput: (email) =>
                              _authViewModel.fields.setEmail(email),
                        ),
                        const SizedBox(height: 16),
                        _RxPasswordSignInField(
                          onInput: (password) =>
                              _authViewModel.fields.setPassword(password),
                        ),
                        const SizedBox(height: 70),
                        Observer(builder: (context) {
                          return CElevatedButton.primaryActionLarge(
                            context: context,
                            isLoading:
                                _authViewModel.requestSignIn.isPending.value,
                            onPressed: signIn,
                            height: 56,
                            child: Text(
                              'Sing In'.toUpperCase(),
                              style:
                                  themeOf(context).buttonOnPrimaryActionStyle,
                            ),
                          );
                        }),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password?',
                            style: themeOf(context).body1OnBackgroundStyle,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Or',
                                style: themeOf(context).body1OnBackgroundStyle,
                              ),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Image(
                                height: 40,
                                fit: BoxFit.cover,
                                image: AssetImage(Assets.googlePng),
                              ),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              onPressed: () {},
                              icon: const Image(
                                height: 40,
                                fit: BoxFit.cover,
                                image: AssetImage(Assets.fbPng),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Don’t have an account? Sign Up",
                            textAlign: TextAlign.center,
                            style: themeOf(context)
                                .body1OnBackgroundStyle
                                .copyWith(decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RxEmailSignInField extends StatelessWidget {
  const _RxEmailSignInField({Key? key, required this.onInput})
      : super(key: key);

  final Function(String) onInput;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Observer(builder: (context) {
      return StyledAuthTextField(
        hintText: 'Email',
        isFieldCorrect: authViewModel.fields.isEmailValid.value,
        isFieldFailed: authViewModel.fields.isEmailFailed.value,
        failedDescription: authViewModel.fields.emailFailedText.value,
        onInput: onInput,
        onFieldInFocus: () {
          runInAction(() {
            authViewModel.fields.isEmailFailed.value = false;
            authViewModel.fields.emailFailedText.value = null;
            authViewModel.fields.refreshRequestFailedStatus();
          });
        },
      );
    });
  }
}

class _RxPasswordSignInField extends StatelessWidget {
  const _RxPasswordSignInField({Key? key, required this.onInput})
      : super(key: key);

  final Function(String) onInput;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Observer(builder: (context) {
      return StyledAuthTextField(
        hintText: 'Password',
        isPassword: true,
        isFieldCorrect: authViewModel.fields.isPasswordValid.value,
        isFieldFailed: authViewModel.fields.isPasswordFailed.value,
        failedDescription: authViewModel.fields.passwordFailedText.value,
        onInput: onInput,
        onFieldInFocus: () {
          runInAction(() {
            authViewModel.fields.isPasswordFailed.value = false;
            authViewModel.fields.passwordFailedText.value = null;
            authViewModel.fields.refreshRequestFailedStatus();
          });
        },
      );
    });
  }
}
