import 'dart:developer';

import 'package:duotask/core/error/failures.dart';
import 'package:duotask/core/obs/observable_request.dart';
import 'package:duotask/domain/repositories/auth_repository.dart';
import 'package:duotask/domain/repositories/token_repository.dart';
import 'package:duotask/presentation/view_models/auth_fields_view_model.dart';
import 'package:mobx/mobx.dart';

class AuthViewModel {
  AuthViewModel(
      {required AuthRepository authRepository,
      required TokenRepository tokenRepository})
      : _authRepository = authRepository,
        _tokenRepository = tokenRepository;

  final AuthRepository _authRepository;
  final TokenRepository _tokenRepository;

  final fields = AuthFieldsViewModel(
    refreshRequestFailedWithEmail: true,
    refreshRequestFailedWithPassword: true,
  );

  final ObservableRequest<String?> requestSignIn = ObservableRequest<String?>(
    defaultValue: null,
  );

  late final Computed<bool> successSignIn = Computed(() =>
      requestSignIn.isFulfilled.value && requestSignIn.data.value != null);

  void _checkFields() {
    runInAction(() {
      if (fields.isEmailValid.value == false) {
        fields.isEmailFailed.value = true;
        fields.emailFailedText.value = 'Invalid email. Check and try again';
      }

      if (fields.isPasswordValid.value == false) {
        fields.isPasswordFailed.value = true;
        fields.passwordFailedText.value = 'Use at least 8 characters';
      }
    });
  }

  Future<void> executeSignIn() async {
    if (requestSignIn.isPending.value) {
      return;
    }

    _checkFields();
    if (fields.emailFailedText.value != null ||
        fields.passwordFailedText.value != null) {
      return;
    }

    final response = await requestSignIn.execute(
      request: () async {
        final authToken = await _authRepository.signIn(
          fields.email.value,
          fields.password.value,
        );

        final isSaved = await _tokenRepository.saveToken(authToken);

        return isSaved ? authToken : null;
      },
    );

    log('** executeSignIn() ==> response=$response');

    if (requestSignIn.isRejected.value &&
        requestSignIn.failure.value is NotCorrectCredentialsFailure) {
      runInAction(() {
        fields.requestFailed.value = true;
        fields.isEmailFailed.value = true;
        fields.isPasswordFailed.value = true;
        fields.passwordFailedText.value = 'Email or password is incorrect';
      });
      log(
        '** executeSignIn() ==> REJECTED',
        error: requestSignIn.failure.value,
      );
    }
  }
}
