import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/client.dart';

import '../models/models.dart';

class WebClient {
  final Duration delay;

  const WebClient({this.delay = const Duration(microseconds: 3000)});

  Future<List<TaskEntity>> fetchTasks() async {
    print('fetching tasks');
    return Future.delayed(
        delay,
        () => [
              TaskEntity(true, true, '1', 'Need to go on Vacation', 'Task'),
              TaskEntity(false, true, '2', 'Global news', 'News'),
              TaskEntity(true, false, '4', 'Flycash', 'Testing Flycash'),
              TaskEntity(false, false, '5', 'Appwrite', 'description'),
              TaskEntity(false, true, '6', 'Sample', 'Test'),
            ]);
  }

  Future<bool> postTasks(TaskEntity task) async {
    Client client = Client(selfSigned: true);
    const API_ENDPOINT = "http://10.0.2.2/v1";
    const PROJECT_ID = "5ee7c6be5d831";
    const COLLECTION_ID = "5ee9f45b5d217";
    client
        .setEndpoint('$API_ENDPOINT/') // Your API Endpoint
        .setProject('$PROJECT_ID') // Your project ID
        .selfSigned;

    Database database = Database(client);
    try {
      await database.createDocument(
          collectionId: '$COLLECTION_ID',
          data: json.encode(task.toJson()),
          read: ['*'],
          write: ['*']);
    } catch (e) {
      print(e.toString());
    }
    return Future.value(true);
  }

  Future<bool> deleteTasks(String taskId) async {
    String documentId = await getDocumentID(taskId);
    Client client = Client(selfSigned: true);
    const API_ENDPOINT = "http://10.0.2.2/v1";
    const PROJECT_ID = "5ee7c6be5d831";
    const COLLECTION_ID = "5ee9f45b5d217";
    client
        .setEndpoint('$API_ENDPOINT/') // Your API Endpoint
        .setProject('$PROJECT_ID') // Your project ID
        .selfSigned;

    Database database = Database(client);

    try {
      await database.deleteDocument(
          collectionId: '$COLLECTION_ID', documentId: documentId);
    } catch (e) {
      print(e.toString());
    }

    return true;
  }

  Future<String> getDocumentID(String taskId) async {
    String documentId;

    Client client = Client(selfSigned: true);
    const API_ENDPOINT = "http://10.0.2.2/v1";
    const PROJECT_ID = "5ee7c6be5d831";
    const COLLECTION_ID = "5ee9f45b5d217";
    client
        .setEndpoint('$API_ENDPOINT/') // Your API Endpoint
        .setProject('$PROJECT_ID') // Your project ID
        .selfSigned;

    Database database = Database(client);

    try {
      Response<dynamic> result = await database.listDocuments(
          collectionId: '$COLLECTION_ID', filters: ['id=$taskId']);

      documentId = await result.data['documents'][0]['\$id'];
    } catch (e) {
      print(e.toString());
      //TODO:: display error instead
      //  return documentId;
    }
    return documentId;
  }
}
