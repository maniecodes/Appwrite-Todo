import 'package:appwrite/appwrite.dart';
import '../models/models.dart';

class UserRepository {
  Client client = Client(selfSigned: true);
  static const API_ENDPOINT = "http://10.0.2.2/v1";
  static const PROJECT_ID = "5ee7c6be5d831";
  static const COLLECTION_ID = "5ee7f40c38388";

  // Signup a user and also create an account session.
  Future<String> signup(
      {String email, String password, String name, String phone}) async {
    String uid;
    String errorMessage;
    client
        .setEndpoint('$API_ENDPOINT/account') // Your API Endpoint
        .setProject('$PROJECT_ID') // Your project ID
        .selfSigned;

    Account account = Account(client);
    try {
      Response<dynamic> result = await account.create(
          email: '$email', password: '$password', name: '$name');
      uid = result.data['registration'].toString();
      if (uid != null) {
        print('creating user session....');
        await createUserSession(email, password);
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

  Future saveUserDetails(String email, String name, String phone) async {
    final userID = await currentUser();
    client
        .setEndpoint('$API_ENDPOINT/') // Your API Endpoint
        .setProject('$PROJECT_ID') // Your project ID
        .selfSigned;

    Database database = Database(client);

    try {
      await database.createDocument(
          collectionId: '$COLLECTION_ID',
          data: {'uid': userID, 'email': email, 'name': name, 'phone': phone},
          read: ['*'],
          write: ['*']);
      // return result.data;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserEntity> getUserInfo() async {
    final userID = await currentUser();
    Map<String, dynamic> json = {};
    print(userID);
    print('i got inside here');

    client
        .setEndpoint('$API_ENDPOINT/') // Your API Endpoint
        .setProject('$PROJECT_ID') // Your project ID
        .selfSigned;

    Database database = Database(client);

    try {
      Response<dynamic> result = await database.listDocuments(
          collectionId: '$COLLECTION_ID', filters: ['uid=$userID']);
      json = result.data['documents'][0];
      return UserEntity.fromJson(json);
    } catch (e) {
      print(e.toString());
      //TODO:: display error instead
      return UserEntity.fromJson(json);
    }
  }

  Future<bool> createUserSession(String email, String password) async {
    print('create user session');
    String errorMessage;
    client
        .setEndpoint('$API_ENDPOINT/account/sessions') // Your API Endpoint
        .setProject('$PROJECT_ID') // Your project ID
        .selfSigned;

    Account account = Account(client);

    try {
      Response<dynamic> result = await account.createSession(
        email: '$email',
        password: '$password',
      );

      if (result.statusCode == 201) {
        return true;
      } else {
        print('failed to create user session');
        return false;
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

  Future<bool> isSignedIn() async {
    print('is signed in');

    String session = await getSession();
    print(session);
    if (session != null) {
      return true;
    }
    return false;
  }

  Future<String> getSession() async {
    print('get session id');
    String sessionId;
    client
            .setEndpoint('$API_ENDPOINT/account/sessions') // Your API Endpoint
            .setProject('$PROJECT_ID') // Your project ID
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
      //print('error in get session');
      //print(error.toString());
      sessionId = null;
    }
    return sessionId;
  }

  Future<String> currentUser() async {
    print('got into current user');
    String uid;
    String errorMessage;
    client
            .setEndpoint('$API_ENDPOINT/account') // Your API Endpoint
            .setProject('$PROJECT_ID') // Your project ID
        ;
    Account account = Account(client);
    try {
      Response<dynamic> result = await account.get();
      if (result.statusCode == 200) {
        // print(result.data);
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

  signOut() async {
    print('loggin out');
    String session = await getSession();
    print(session);
    if (session != null) {
      Account account = Account(client);

      client
              .setEndpoint(
                  '$API_ENDPOINT/account/sessions/$session') // Your API Endpoint
              .setProject('$PROJECT_ID') // Your project ID
          ;

      Future result = account.deleteSession(
        sessionId: '$session',
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
