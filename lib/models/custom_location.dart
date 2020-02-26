import 'reachable.dart';
import 'direction.dart';
import 'package:location/location.dart';

class CustomLocation implements Reachable {
  Location _location;

  // TODO: change to whatever is returned by current location function call of location package.
  CustomLocation(String coord) {
    //coordinates = coordinates;
  }

  /*
   * See
   * https://medium.com/@shubham.narkhede8/flutter-google-map-with-direction-6a26ad875083
   * and 
   * https://github.com/flutter/plugins/blob/master/packages/google_maps_flutter/google_maps_flutter/example/lib/place_polyline.dart
  */
  List<Direction> pathTo(CustomLocation destination) {
    //TODO: use google API to retrieve list of directions.
  }
  
}