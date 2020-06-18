import 'package:appwrite/appwrite.dart';
import '../models/models.dart';

class UserRepository {
  Client client = Client(selfSigned: true);
  // static const API_ENDPOINT = "http://127.0.0.1/v1";
  static const API_ENDPOINT = "http://10.0.2.2/v1";
  static const PROJECT_ID = "5eeafe5ee3d2c";
  static const COLLECTION_ID = "5eeafe9b73454";

  // Signup a user and also create an account session.
  Future<String> signup(
      {String email, String password, String name, String phone}) async {
    String uid;
    String errorMessage;

    client
        .setEndpoint(API_ENDPOINT) // Your API Endpoint
        .setProject(PROJECT_ID) // Your project ID
        .selfSigned;

    Account account = Account(client);
    try {
      Response<dynamic> result = await account.create(
          email: '$email', password: '$password', name: '$name');
      uid = result.data['registration'].toString();
      if (uid != null) {
        //Create user session after succesfully signing up
        await createUserSession(email, password);

        /// Save user [email, name, phone] to appwrite
        await saveUserDetails(email, name, phone);
      }
    } catch (error) {
      switch (error.response.data['code'].toString()) {
        case "429":
          errorMessage = "Too may request. Try again later";
          break;
        case "409":
          errorMessage = "Account Already Exists";
          break;
        case "401":
          errorMessage = "Unauthorized user";
          break;
        default:
          errorMessage = "Something went wrong";
      }
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return uid;
  }

  // Save User information into the database
  Future saveUserDetails(String email, String name, String phone) async {
    // Get current logged in user ID
    final userID = await currentUser();
    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;

    Database database = Database(client);

    try {
      await database.createDocument(
          collectionId: COLLECTION_ID,
          data: {'uid': userID, 'email': email, 'name': name, 'phone': phone},
          read: ['*'],
          write: ['*']);
    } catch (e) {
      print(e.toString());
    }
  }

  // Get user information
  Future<UserEntity> getUserInfo() async {
    // Get current logged in user ID
    final userID = await currentUser();

    Map<String, dynamic> json = {};

    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;

    Database database = Database(client);

    try {
      Response<dynamic> result = await database
          .listDocuments(collectionId: COLLECTION_ID, filters: ['uid=$userID']);

      json = result.data['documents'][0];

      return UserEntity.fromJson(json);
    } catch (e) {
      print(e.toString());
      //TODO:: display error instead
      return UserEntity.fromJson(json);
    }
  }

  // Create user session after signup
  Future<bool> createUserSession(String email, String password) async {
    String errorMessage;
    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;

    Account account = Account(client);

    try {
      Response<dynamic> result = await account.createSession(
        email: email,
        password: password,
      );
      print(result);
      if (result.statusCode == 201) {
        print('cre');
        return true;
      } else {
        print('failed to create user session');
        return false;
      }
    } catch (error) {
      print(error);

      switch (error.response.data['code'].toString()) {
        case "429":
          errorMessage = "Too may request. Try again later";
          break;
        case "409":
          errorMessage = "Account Already Exists";
          break;
        case "401":
          errorMessage = "Invalid email / password";
          break;
        default:
          errorMessage = "Something went wrong";
      }
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return false;
  }

  // Check if user session is active.
  Future<bool> isSignedIn() async {
    String session = await getSession();
    if (session != null) {
      return true;
    }
    return false;
  }

  // Get current session
  Future<String> getSession() async {
    String sessionId;
    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;
    Account account = Account(client);
    try {
      Response<dynamic> result = await account.getSessions();
      if (result.statusCode == 200) {
        sessionId = result.data[0]['\$id'];
      } else {
        sessionId = null;
      }
    } catch (error) {
      sessionId = null;
    }
    return sessionId;
  }

  //get current user ID
  Future<String> currentUser() async {
    String uid;
    String errorMessage;
    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;
    Account account = Account(client);
    try {
      Response<dynamic> result = await account.get();
      if (result.statusCode == 200) {
        uid = result.data['registration'].toString();
      }
    } catch (error) {
      switch (error.response.data['code'].toString()) {
        case "429":
          errorMessage = "Too may request. Try again later";
          break;
        case "409":
          errorMessage = "Account Already Exists";
          break;
        case "401":
          errorMessage = "Unauthorized user";
          break;
        default:
          errorMessage = "Something went wrong";
      }
    }
    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    // print(uid);
    return uid;
  }

  //Signout and end current session
  signOut() async {
    String session = await getSession();
    print(session);
    if (session != null) {
      Account account = Account(client);

      client
              .setEndpoint(API_ENDPOINT) // Your API Endpoint
              .setProject(PROJECT_ID) // Your project ID
          ;

      Future result = account.deleteSession(
        sessionId: session,
      );

      result.then((response) async {
        print('logged out');
        print(response);
      }).catchError((error) {
        print(error.response);
      });
    }
  }
}
