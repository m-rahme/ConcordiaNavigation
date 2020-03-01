import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'network.dart';

//Google API key
//TODO: Hide Key
const String apiKey = 'AIzaSyBHXKzGZEeBhP_m3QQ6vpI0hRODxeeEWl0';

//This class will fetch the JSON from URL
class DirectionsService {
  static final String mapsUrl = 'maps.googleapis.com/maps/api/directions/json';

  static Future<String> getDirections(final LatLng start, final LatLng end,
      {String mode = "driving"}) async {
    return await Network.getData(
        'https://$mapsUrl?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&mode=$mode&key=$apiKey');
  }
}
