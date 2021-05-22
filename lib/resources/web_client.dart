import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:meta/meta.dart';

import '../models/models.dart';

class WebClient {
  // static const API_ENDPOINT = "http://192.168.1.100/v1";
  static const API_ENDPOINT = "http://10.0.2.2/v1";
  final Client client = Client();

  // static const API_ENDPOINT = "http://127.0.0.1/v1";
  static const PROJECT_ID = "60a783b9b584e";
  static const DATABASE_COLLECTION_ID = "60a7999a412fd";
  static const USER_COLLECTION_ID = "60a8d9d2c3646";
  WebClient({@required client}) : assert(client != null);

  Future<String> getCurrentUser() async {
    String uid;
    String errorMessage;
    client.setEndpoint(API_ENDPOINT).setProject(PROJECT_ID);
    Account account = Account(client);
    try {
      Response<dynamic> result = await account.get();
      print('get current user id');
      if (result.statusCode == 200) {
        uid = result.data['registration'].toString();
        print(uid);
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

  // Get task attached to a user.
  Future<List<TaskEntity>> fetchTasks(String userId) async {
    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;
    Database database = Database(client);
    print('fetch all task');

    try {
      Response<dynamic> result = await database.listDocuments(
          collectionId: DATABASE_COLLECTION_ID,
          filters: ['uid=$userId'],
          orderField: 'createdDateTime',
          orderType: OrderType.desc);
      print(result);
      final json = result.data['documents'];
      print(json);
      final tasks =
          (json).map<TaskEntity>((task) => TaskEntity.fromJson(task)).toList();
      return tasks;
    } catch (e) {
      print(e.toString());
      //TODO:: display error
    }
  }

  Future<UserEntity> fetchUserInfo(String userID) async {
    Map<String, dynamic> json = {};
    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;
    Database database = Database(client);

    try {
      Response<dynamic> result = await database.listDocuments(
          collectionId: USER_COLLECTION_ID, filters: ['uid=$userID']);

      json = await result.data['documents'][0];

      return UserEntity.fromJson(json);
    } catch (e) {
      print(e.toString());
      //TODO:: display error instead
      return UserEntity.fromJson(json);
    }
  }

  //
  Future<List<TaskEntity>> searchTasks(String search) async {
    final userID = await getCurrentUser();
    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;

    Database database = Database(client);
    print('sera all task');
    print(search);

    try {
      Response<dynamic> result = await database.listDocuments(
          collectionId: DATABASE_COLLECTION_ID,
          filters: ['uid=$userID'],
          orderField: 'createdDateTime',
          orderType: OrderType.desc,
          search: search);
      final json = result.data['documents'];
      final tasks =
          (json).map<TaskEntity>((task) => TaskEntity.fromJson(task)).toList();
      print('searching');
      print(tasks);
      print('end');
      return tasks;
    } catch (e) {
      print(e.toString());
      //TODO:: display error
    }
  }

  // Save task into the database
  Future<bool> postTasks(TaskEntity task) async {
    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;

    Database database = Database(client);
    try {
      await database.createDocument(
          collectionId: DATABASE_COLLECTION_ID,
          data: task.toJson(),
          read: ['*'],
          write: ['*']);
    } catch (e) {
      print(e.toString());
    }
    return Future.value(true);
  }

  // Delete task from the database
  Future<bool> deleteTasks(String taskId) async {
    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;

    Database database = Database(client);
    String documentId = await getDocumentID(taskId);

    try {
      await database.deleteDocument(
          collectionId: DATABASE_COLLECTION_ID, documentId: documentId);
    } catch (e) {
      print(e.toString());
    }

    return true;
  }

  // Update a task on the database
  Future<bool> updateTasks(String taskId, TaskEntity task) async {
    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;
    String documentId = await getDocumentID(taskId);
    Database database = Database(client);
    try {
      Response<dynamic> result = await database.updateDocument(
        collectionId: DATABASE_COLLECTION_ID,
        documentId: documentId,
        data: task.toJson(),
        read: ['*'],
        write: ['*'],
      );

      print(result.data);
    } catch (e) {
      print(e.toString());
    }
  }

  // Get document id
  Future<String> getDocumentID(String taskId) async {
    String documentId;

    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;

    Database database = Database(client);

    try {
      Response<dynamic> result = await database.listDocuments(
          collectionId: DATABASE_COLLECTION_ID, filters: ['id=$taskId']);

      documentId = await result.data['documents'][0]['\$id'];
    } catch (e) {
      print(e.toString());
      //TODO:: display error instead
      //  return documentId;
    }
    return documentId;
  }

  // Signup a user and also create an account session.
  Future<String> signup(
      String email, String password, String name, String phone) async {
    String uid;
    String errorMessage;

    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;

    print(client.toString());
    Account account = Account(client);
    print(email);
    print(password);
    print(name);
    try {
      Response<dynamic> result = await account.create(
          email: '$email', password: '$password', name: '$name');
      print(result.toString());
      uid = result.data['registration'].toString();
      if (uid != null) {
        //Create user session after succesfully signing up
        await createUserSession(email, password);

        /// Save user [email, name, phone] to appwrite
        await saveUserDetails(email, name, phone);
      }
    } catch (error) {
      print(error.message);
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
        print('create');
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

  // Save User information into the database
  Future saveUserDetails(String email, String name, String phone) async {
    // Get current logged in user ID
    final userID = await getCurrentUser();
    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;

    Database database = Database(client);

    try {
      await database.createDocument(
          collectionId: USER_COLLECTION_ID,
          data: {'uid': userID, 'email': email, 'name': name, 'phone': phone},
          read: ['*'],
          write: ['*']);
    } catch (e) {
      print(e.message);
    }
  }

  // Get user information
  Future<UserEntity> getUserInfo() async {
    // Get current logged in user ID
    final userID = await getCurrentUser();

    Map<String, dynamic> json = {};

    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;

    Database database = Database(client);

    try {
      Response<dynamic> result = await database.listDocuments(
          collectionId: USER_COLLECTION_ID, filters: ['uid=$userID']);

      json = await result.data['documents'][0];

      return UserEntity.fromJson(json);
    } catch (e) {
      print(e.toString());
      //TODO:: display error instead
      return UserEntity.fromJson(json);
    }
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

  //Signout and end current session
  signOut() async {
    String session = await getSession();

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
