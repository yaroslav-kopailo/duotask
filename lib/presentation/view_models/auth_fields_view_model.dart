import 'package:duotask/core/helper/string_ext.dart';
import 'package:duotask/core/util/validator_base.dart';
import 'package:mobx/mobx.dart';

class AuthFieldsViewModel {
  AuthFieldsViewModel({
    this.refreshRequestFailedWithEmail = false,
    this.refreshRequestFailedWithPassword = false,
  });

  final bool refreshRequestFailedWithEmail;
  final bool refreshRequestFailedWithPassword;

  final Observable<String> email = Observable('');

  final Observable<String> password = Observable('');

  final Observable<bool> requestFailed = Observable(false);

  final Observable<bool> isEmailFailed = Observable(false);

  final Observable<bool> isPasswordFailed = Observable(false);

  final Observable<String?> emailFailedText = Observable(null);

  final Observable<String?> passwordFailedText = Observable(null);

  late final Computed<bool> isEmailValid =
      Computed(() => validator.email(email.value));

  late final Computed<bool> isPasswordValid =
      Computed(() => password.value.isValidPasswordLength);

  void setEmail(String value) {
    runInAction(() {
      email.value = value.trim();
      if (isEmailFailed.value) {
        isEmailFailed.value = false;
        emailFailedText.value = null;
      }
      if (refreshRequestFailedWithEmail) refreshRequestFailedStatus();
    });
  }

  void setPassword(String value) {
    runInAction(() {
      password.value = value.trim();
      if (isPasswordFailed.value) {
        isPasswordFailed.value = false;
        passwordFailedText.value = null;
      }
      if (refreshRequestFailedWithPassword) refreshRequestFailedStatus();
    });
  }

  void refreshRequestFailedStatus() {
    runInAction(() {
      if (requestFailed.value) {
        requestFailed.value = false;
        emailFailedText.value = null;
        passwordFailedText.value = null;
        isEmailFailed.value = false;
        isPasswordFailed.value = false;
      }
    });
  }
}
