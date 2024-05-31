import 'dart:convert';
import 'dart:math';

import 'package:duotask/core/storage/json_locale_storage.dart';
import 'package:duotask/data/models/token_model.dart';
import 'package:http/http.dart' as http;

mixin MockClient {
  static final Random _random = Random();

  Future<http.Response> mockRequest({
    required Future<http.Response> Function() request,
    String? authToken,
  }) async {
    // Random delay between 500 and 1500 ms
    final delay = _random.nextInt(1000) + 500;
    await Future.delayed(Duration(milliseconds: delay));

    // Randomly simulate errors
    final errorChance = _random.nextDouble();
    if (errorChance < 0.1) {
      return http.Response('Server Error 500: Internal Server Error', 500);
    } else if (errorChance < 0.2) {
      return http.Response('Server Error 503: Service Unavailable', 503);
    }

    if (authToken != null) {
      return await _checkToken(
        authToken,
        defaultResponse: await request(),
      );
    }

    return request();
  }

  Future<http.Response> _checkToken(
    String authToken, {
    required http.Response defaultResponse,
  }) async {
    final correctAuthTokenData = await JsonLocaleStorage.loadAuthTokenData();
    final correctAuthToken = TokenModel.fromJson(
      jsonDecode(
        correctAuthTokenData,
      ),
    );

    if (authToken != correctAuthToken.token) {
      return http.Response('Unauthorized', 401);
    }

    return defaultResponse;
  }
}
