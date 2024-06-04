abstract class AuthRepository {
  Future<String> signIn(String email, String password);
}
