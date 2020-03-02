import 'package:http/http.dart';

//This class is used to send a URL request
class Network {
  static Future getData(String url) async {
    print('Calling uri: $url');
    Response response = await get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }
}
