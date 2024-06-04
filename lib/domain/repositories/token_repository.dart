abstract class TokenRepository {
  String? getToken();

  Future<bool> saveToken(String authToken);

  Future<String?> resetToken();
}
