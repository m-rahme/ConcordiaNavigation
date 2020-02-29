import 'dart:async';
import 'package:location/location.dart';
import 'package:concordia_navigation/models/user_location.dart';

class LocationService {
  UserLocation _current = UserLocation.sgw();
  Location _location = Location();
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>();

  LocationService() {
    _locationController.add(_current);
    registerLocationUpdates();
  }

  Stream<UserLocation> get stream => _locationController.stream;

  Future<UserLocation> getLocation() async {
    try {
      _current = new UserLocation.fromData(await _location.getLocation());
    } catch (e) {
      print('Location Service Error: $e');
    }

    return _current;
  }

  void registerLocationUpdates() {
    // request permission to use location
    _location.requestPermission().then((granted) async {
      if (granted != null) {
        // listen to the onLocationChanged stream and emit over our controller
        _location.onLocationChanged().listen((position) {
          if (position != null) {
            _current = new UserLocation.fromData(position);
            _locationController.add(_current);
          }
        });
      }
    });
  }
}
