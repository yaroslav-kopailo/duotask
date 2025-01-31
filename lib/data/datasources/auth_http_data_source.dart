import 'dart:convert';

import 'package:duotask/core/error/exceptions.dart';
import 'package:duotask/core/network/mock_client.dart';
import 'package:duotask/core/storage/json_locale_storage.dart';
import 'package:duotask/data/models/auth_model.dart';
import 'package:duotask/data/models/token_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthHttpDataSource {
  Future<String> signUp(String email, String password);

  Future<String> signIn(String email, String password);
}

class MockAuthHttpDataSourceImpl with MockClient implements AuthHttpDataSource {
  @override
  Future<String> signUp(String email, String password) async {
    // Simulate successful registration
    final resp = await mockRequest(
      request: () async {
        final data = await JsonLocaleStorage.loadAuthTokenData();

        return http.Response(data, 200);
      },
    );

    if (resp.statusCode != 200) {
      throw ApiException(statusCode: resp.statusCode, message: resp.body);
    }

    final model = TokenModel.fromJson(jsonDecode(resp.body));

    return model.token;
  }

  @override
  Future<String> signIn(String email, String password) async {
    // Simulate successful authentication
    final resp = await mockRequest(
      request: () async {
        final correctCreds = AuthModel.fromJson(
          jsonDecode(await JsonLocaleStorage.loadAuthCredData()),
        );
        final actualCreds = AuthModel(email: email, password: password);

        if (actualCreds.email == correctCreds.email &&
            actualCreds.password == correctCreds.password) {
          final data = await JsonLocaleStorage.loadAuthTokenData();
          return http.Response(data, 200);
        }

        return http.Response(
          'Server Error 401: No account with such an email or password',
          401,
        );
        ;
      },
    );

    if (resp.statusCode != 200) {
      throw ApiException(statusCode: resp.statusCode, message: resp.body);
    }

    final model = TokenModel.fromJson(jsonDecode(resp.body));

    return model.token;
  }
}
