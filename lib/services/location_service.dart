import 'dart:async';
import 'package:location/location.dart';
import 'package:concordia_navigation/models/user_location.dart';

class LocationService {
  static LocationService _instance;
  UserLocation _current;
  Location _location;
  StreamController<UserLocation> _locationController = StreamController<UserLocation>();

  LocationService._() { // private constructor
    _locationController.add(_current);
    _location = Location();
    setCurrent();
    registerLocationUpdates();
  }

  static getInstance() {
    if (_instance == null) {
      _instance = LocationService._();
    }
    return _instance;
  }

  Stream<UserLocation> get stream => _locationController.stream;

  Future<LocationData> getLocationData() async {
    LocationData loc;
    try {
      loc = await _location.getLocation();
    } catch (e) {
      print('Location Service Error: $e');
    }

    return loc;
  }

  void setCurrent() async {
    Future<LocationData> future = getLocationData();
    future.then((value) {
      _current = new UserLocation.fromLocationData(value);
    });
  }

  void registerLocationUpdates() {
    // request permission to use location
    _location.requestPermission().then((granted) async {
      if (granted != null) {
        // listen to the onLocationChanged stream and emit over our controller
        _location.onLocationChanged().listen((position) {
          if (position != null) {
            _current = new UserLocation.fromLocationData(position);
            _locationController.add(_current);
          }
        });
      }
    });
  }
}
