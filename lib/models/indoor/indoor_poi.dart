import 'indoor_location.dart';
import '../uni_location.dart';

/// Model class for indoor points of interest
class IndoorPOI extends IndoorLocation {
  IndoorPOI.fromJson(json,
      {UniLocation parent, double latitude, double, longitude})
      : super.fromJson(json, parent: parent);
}
