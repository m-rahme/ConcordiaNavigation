import 'package:http/http.dart';
import 'package:meta/meta.dart' show visibleForTesting;

//This class is used to send a URL request
class Network {
  static Client _client = new Client();

  const Network();

  @visibleForTesting
  set client(Client client) => _client = client;

  Future getData(String url) async {
    print('Calling uri: $url');
    Response response = await _client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }
}
