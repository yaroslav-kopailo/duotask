import 'package:duotask/domain/repositories/token_repository.dart';
import 'package:mobx/mobx.dart';

class TokenViewModel {
  TokenViewModel({required TokenRepository tokenRepository})
      : _tokenRepository = tokenRepository {
    restoreAuthToken();
  }

  final TokenRepository _tokenRepository;

  final Observable<String?> authToken = Observable(null);

  late final Computed<bool> isAuthorized =
      Computed(() => authToken.value != null);

  void restoreAuthToken() {
    runInAction(() {
      authToken.value = _tokenRepository.getToken();
    });
  }

  void setAuthToken(String token) {
    runInAction(() {
      authToken.value = token;
    });
  }
}
