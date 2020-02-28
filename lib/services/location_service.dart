import 'dart:async';
import 'package:location/location.dart';
import 'package:concordia_navigation/models/user_location.dart';

class LocationService {
  UserLocation _current;
  Location _location = Location();
  StreamController<UserLocation> _locationController =
    StreamController<UserLocation>();

  LocationService() {
    // request permission to use location
    _location.requestPermission().then((granted) async {
      if (granted != null) {
        // listen to the onLocationChanged stream and emit over our controller
        _location.onLocationChanged().listen((position) {
          if (position != null) {
            _current = UserLocation(position.latitude, position.longitude);
            _locationController.add(_current);
          }
        });
      }
    });
  }

  Stream<UserLocation> get stream => _locationController.stream;

  Future<UserLocation> getPosition() async {
    try {
      var position = await _location.getLocation();
      _current = UserLocation(position.latitude, position.longitude);
    } catch(e) {
      print('Location Service Error: $e');
    }

    return _current;
  }


}