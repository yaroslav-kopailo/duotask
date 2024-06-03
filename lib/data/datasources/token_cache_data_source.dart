import 'package:duotask/core/helper/hive_keys.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class TokenCacheDataSource {
  String? getToken();

  Future<bool> saveToken(String authToken);

  Future<String?> resetToken();
}

class TokenCacheDataSourceImpl implements TokenCacheDataSource {
  TokenCacheDataSourceImpl({required Box tokenCacheBox})
      : _tokenCacheBox = tokenCacheBox;

  final Box _tokenCacheBox;

  @override
  String? getToken() {
    return _tokenCacheBox.get(HiveKeys.authTokenKey);
  }

  @override
  Future<String?> resetToken() async {
    final token = getToken();
    await _tokenCacheBox.delete(HiveKeys.authTokenKey);
    return token;
  }

  @override
  Future<bool> saveToken(String authToken) async {
    await _tokenCacheBox.put(HiveKeys.authTokenKey, authToken);
    return true;
  }
}
