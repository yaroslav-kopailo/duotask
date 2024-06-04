import 'package:duotask/data/datasources/token_cache_data_source.dart';
import 'package:duotask/domain/repositories/token_repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  TokenRepositoryImpl({required TokenCacheDataSource tokenCacheDataSource})
      : _tokenCacheDataSource = tokenCacheDataSource;

  final TokenCacheDataSource _tokenCacheDataSource;

  @override
  String? getToken() {
    return _tokenCacheDataSource.getToken();
  }

  @override
  Future<String?> resetToken() async {
    return _tokenCacheDataSource.resetToken();
  }

  @override
  Future<bool> saveToken(String authToken) async {
    return _tokenCacheDataSource.saveToken(authToken);
  }
}
