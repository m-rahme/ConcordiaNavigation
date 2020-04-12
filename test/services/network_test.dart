import 'package:concordia_navigation/services/network.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart';

class MockClient extends Mock implements Client {}

void main() {
  group('Network', () {
    Network network;
    MockClient mockClient;

    setUp(() async {
      network = new Network();
      mockClient = new MockClient();
      network.client = mockClient;
      when(mockClient.get(any)).thenAnswer((_) {
        Response response = new Response("data", 200);
        return Future.value(response);
      });
    });

    test('getData() returns body of HTTP GET request', () async {
      String response = await network.getData("url");
      expect(response, "data");
    });
  });
}
