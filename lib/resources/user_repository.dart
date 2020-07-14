import '../models/models.dart';

abstract class UserRepository {
  /// Loads tasks first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  Future<String> signup(
      String email, String password, String name, String phone);

  Future saveUserDetails(String email, String name, String phone);

  Future<UserEntity> getUserInfo();

  Future<bool> createUserSession(String email, String password);

  Future<String> getSession();

  Future<String> getCurrentUser();

  signOut();

  Future<bool> isSignedIn();
}
