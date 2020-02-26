import 'network.dart';

const String apiKey = 'AIzaSyBHXKzGZEeBhP_m3QQ6vpI0hRODxeeEWl0';
const String mapAPIURL =
    'https://maps.googleapis.com/maps/api/directions/json?origin=45.4957,%20-73.5781&destination=45.4582,%20-73.6405';
const String origin = 'origin=';
const String destination = 'destination=';
const String apiKeyString = '&key=$apiKey';

class Navigation {
  Future<dynamic> getMapDirections() async {
    Network network = Network('$mapAPIURL$apiKeyString');

    var directionsData = await network.getData();
    print(directionsData);
    return directionsData;
  }
}