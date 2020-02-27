import 'network.dart';

const String apiKey = 'AIzaSyBHXKzGZEeBhP_m3QQ6vpI0hRODxeeEWl0';
String mapAPIURL = 'https://maps.googleapis.com/maps/api/directions/json?' +
    _origin +
    '45.4957,%20-73.5781' +
    _destination +
    '45.4582,%20-73.6405' +
    _mode;
String _mode = '&mode=driving';
String _origin = 'origin=';
String _destination = '&destination=';
const String apiKeyString = '&key=$apiKey';

class Navigation {
  Future<dynamic> getMapDirections() async {
    Network network = Network('$mapAPIURL$apiKeyString');

    var directionsData = await network.getData();
    print(directionsData);
    return directionsData;
  }
}
