import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:concordia_navigation/services/network.dart';

const String apiKey = 'AIzaSyBHXKzGZEeBhP_m3QQ6vpI0hRODxeeEWl0';

class DirectionsService {
  static final String mapsUrl =
      'maps.googleapis.com/maps/api/directions/json'; //origin=45.4957,%20-73.5781&destination=45.4582,%20-73.6405';

  static Future<String> getDirections(final LatLng start, final LatLng end,
      {String mode = "driving"}) async {
    return await Network.getData(
        'https://$mapsUrl?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&mode=$mode&key=$apiKey');
  }
}
