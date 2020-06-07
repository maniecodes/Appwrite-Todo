import 'package:appwrite/appwrite.dart';

class UserRepository {
  Client client = Client(selfSigned: true);
  static const API_ENDPOINT = "http://10.0.2.2/v1/";
  static const PROJECT_ID = "5eda5682bbb13";

  // Use Account Create to signup a new user
  Future<String> signup({String email, String password}) async {
    String uid;
    String errorMessage;

    client
            .setEndpoint('$API_ENDPOINT/account') // Your API Endpoint
            .setProject('$PROJECT_ID')
            .selfSigned // Your project ID
        ;

    Account account = Account(client);

    Future result = account.create(
      email: '$email',
      password: '$password',
    );
    result.then((response) {
      print(response);
      uid = response.data['registration'];
    }).catchError((error) {
      print(error.response);
      final responseCode = error.response.data['code'];
      switch (responseCode) {
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
    });

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }

    return uid;
  }
}
