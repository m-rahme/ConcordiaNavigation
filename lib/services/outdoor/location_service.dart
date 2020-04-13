import 'dart:async';
import 'package:concordia_navigation/models/outdoor/user_location.dart';
import 'package:location/location.dart';
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
    updateCurrent();
    registerLocationUpdates();
  }

  @visibleForTesting
  static LocationService getTestInstance(Location location) {
    ///Checks if instance is null before initializing it, else returns instance  --> (Singleton DP)
    if (_location == null) _location = location;
    if (_instance == null) _instance = LocationService._();
    return _instance;
  }

  static LocationService getInstance() {
    ///Checks if instance is null before initializing it, else returns instance  --> (Singleton DP)
    if (_instance == null) {
      _instance = LocationService._();
    }
    return _instance;
  }

  Stream<UserLocation> get stream => _locationController.stream;

  UserLocation get current => _current;

  void setCurrent (LocationData data) {
    if (data != null) {
      _current = new UserLocation.fromLocationData(data);
      _locationController.add(_current);
    }
  }

  /// Checks for (and requests) location permissions
  Future<bool> checkPermission() async {
    PermissionStatus permission = await _location.hasPermission();
    if (permission != PermissionStatus.GRANTED) {
      permission = await _location.requestPermission();
      if (permission != PermissionStatus.GRANTED) {
        return false;
      }
    }
    return true;
  }

  /// Clean wrapper for performing privileged actions
  void withPermission(void method()) {
    checkPermission().then((granted) => {
      if(granted == true) {
        method()
      }
    });
  }

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

  ///Updates _current with real device location
  void updateCurrent() {
    withPermission(() => getLocationData().then((position) => setCurrent(position)));
  }

  ///Listen to location changes to continuously update user location on map
  void registerLocationUpdates() {
    // listen to the onLocationChanged stream and emit over our controller
    withPermission(() => _location.onLocationChanged().listen((position) => setCurrent(position)));
  }
}
