import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/client.dart';

import '../models/models.dart';

class WebClient {
  // static const API_ENDPOINT = "http://127.0.0.1/v1";
  static const API_ENDPOINT = "http://10.0.2.2/v1";
  static const PROJECT_ID = "5eeafe5ee3d2c";
  static const COLLECTION_ID = "5eeb001ebd987";

  const WebClient();

  //TODO::: try to remove this function as it is a duplicate of current user in user_repository.dart
  Future<String> getCurrentUser() async {
    String uid;
    String errorMessage;
    Client client = Client(selfSigned: true);
    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;
    Account account = Account(client);
    try {
      Response<dynamic> result = await account.get();
      if (result.statusCode == 200) {
        uid = result.data['registration'].toString();
        print('current user id: $uid');
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

  Future<List<TaskEntity>> fetchTasks(String userId) async {
    print('got inside here');
    // final userID = await getCurrentUser();
    // print(userID);
    Client client = Client(selfSigned: true);
    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;
    Database database = Database(client);

    try {
      Response<dynamic> result = await database
          .listDocuments(collectionId: COLLECTION_ID, filters: ['uid=$userId']);
      final json = result.data['documents'];
      final tasks =
          (json).map<TaskEntity>((task) => TaskEntity.fromJson(task)).toList();

      print('fetching task list.....');
      print(json);
      return tasks;
    } catch (e) {
      print(e.toString());
      //TODO:: display error instead
      // return TaskEntity.fromJson(json);
    }
  }

  Future<bool> postTasks(TaskEntity task) async {
    Client client = Client(selfSigned: true);
    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;

    Database database = Database(client);
    try {
      await database.createDocument(
          collectionId: COLLECTION_ID,
          data: json.encode(task.toJson()),
          read: ['*'],
          write: ['*']);
    } catch (e) {
      print(e.toString());
    }
    return Future.value(true);
  }

  Future<bool> deleteTasks(String taskId) async {
    Client client = Client(selfSigned: true);
    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;

    Database database = Database(client);
    String documentId = await getDocumentID(taskId);

    try {
      await database.deleteDocument(
          collectionId: COLLECTION_ID, documentId: documentId);
    } catch (e) {
      print(e.toString());
    }

    return true;
  }

  Future<bool> updateTasks(String taskId, TaskEntity task) async {
    Client client = Client(selfSigned: true);
    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;
    String documentId = await getDocumentID(taskId);
    Database database = Database(client);
    try {
      Response<dynamic> result = await database.updateDocument(
        collectionId: COLLECTION_ID,
        documentId: documentId,
        data: json.encode(task.toJson()),
        read: ['*'],
        write: ['*'],
      );

      print(result.data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getDocumentID(String taskId) async {
    String documentId;

    Client client = Client(selfSigned: true);
    client
            .setEndpoint(API_ENDPOINT) // Your API Endpoint
            .setProject(PROJECT_ID) // Your project ID
        ;

    Database database = Database(client);

    try {
      Response<dynamic> result = await database
          .listDocuments(collectionId: COLLECTION_ID, filters: ['id=$taskId']);

      documentId = await result.data['documents'][0]['\$id'];
    } catch (e) {
      print(e.toString());
      //TODO:: display error instead
      //  return documentId;
    }
    return documentId;
  }
}
