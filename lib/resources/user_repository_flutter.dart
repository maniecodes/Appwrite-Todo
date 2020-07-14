import '../resources/repository.dart';
import '../models/models.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Todos and Persist todos.
class UserRepositoryFlutter implements UserRepository {
  final WebClient webClient;

  const UserRepositoryFlutter({
    this.webClient = const WebClient(),
  });

  /// Loads tasks first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  @override
  Future<String> signup(
      String email, String password, String name, String phone) async {
    try {
      return await webClient.signup(email, password, name, phone);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<UserEntity> saveUserDetails(
      String email, String name, String phone) async {
    try {
      return await webClient.saveUserDetails(email, name, phone);
    } catch (e) {
      print(e.toString());
      //TODO:: display error instead
      return null;
    }
  }

  @override
  Future<UserEntity> getUserInfo() async {
    try {
      return await webClient.getUserInfo();
    } catch (e) {
      print(e.toString());
      //TODO:: display error instead
      return null;
    }
  }

  @override
  Future<bool> createUserSession(String email, String password) async {
    try {
      return await webClient.createUserSession(email, password);
    } catch (e) {
      print(e.toString());
      //TODO:: display error instead
      return null;
    }
  }

  @override
  Future<String> getSession() async {
    try {
      return await webClient.getSession();
    } catch (e) {
      print(e.toString());
      //TODO:: display error instead
      return null;
    }
  }

  @override
  Future<String> getCurrentUser() async {
    try {
      return await webClient.getCurrentUser();
    } catch (e) {
      print(e.toString());
      //TODO:: display error instead
      return null;
    }
  }

  @override
  signOut() async {
    try {
      return await webClient.signOut();
    } catch (e) {
      print(e.toString());
      //TODO:: display error instead
      return null;
    }
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      return await webClient.isSignedIn();
    } catch (e) {
      print(e.toString());
      //TODO:: display error instead
      return null;
    }
  }
}
