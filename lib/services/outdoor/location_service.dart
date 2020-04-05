import 'dart:async';
import 'package:location/location.dart';
import 'package:concordia_navigation/models/user_location.dart';
import 'package:meta/meta.dart' show visibleForTesting;

///Location Service, implementing the Singleton Design Pattern
class LocationService {
  static LocationService _instance;
  UserLocation _current;
  static Location _location;
  StreamController<UserLocation> _locationController;

  ///Private Constructor
  LocationService._() {
    _locationController = StreamController<UserLocation>();
    _location ??= Location();
    setCurrent();
    _locationController.add(_current);
    registerLocationUpdates();
  }

  @visibleForTesting
  static getTestInstance(Location location) {
    ///Checks if instance is null before initializing it, else returns instance  --> (Singleton DP)
    if (_location == null) _location = location;
    if (_instance == null) _instance = LocationService._();
    return _instance;
  }

  static getInstance() {
    ///Checks if instance is null before initializing it, else returns instance  --> (Singleton DP)
    if (_instance == null) {
      _instance = LocationService._();
    }
    return _instance;
  }

  Stream<UserLocation> get stream => _locationController.stream;

  ///Fetches user location using the Location Package
  Future<LocationData> getLocationData() async {
    LocationData loc;
    try {
      loc = await _location.getLocation();
    } catch (e) {
      print('Location Service Error: $e');
    }

    return loc;
  }

  ///Sets _current to current user location
  void setCurrent() async {
    Future<LocationData> future = getLocationData();
    future.then((value) {
      _current = new UserLocation.fromLocationData(value);
    });
  }

  ///Listen to location changes to continuously update user location on map
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
