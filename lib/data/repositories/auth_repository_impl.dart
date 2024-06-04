import 'package:duotask/data/datasources/auth_http_data_source.dart';
import 'package:duotask/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthHttpDataSource authHttpDataSource})
      : _authHttpDataSource = authHttpDataSource;

  final AuthHttpDataSource _authHttpDataSource;

  @override
  Future<String> signIn(String email, String password) async {
    return _authHttpDataSource.signIn(email, password);
  }
}
