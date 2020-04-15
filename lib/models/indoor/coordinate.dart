/// Model class for indoor navigation coordinates
class Coordinate {
  double x;
  double y;
  // Retrieves indoor coordinate from json file
  Coordinate.fromJson(Map json)
      : this.x = json['x'] is int ? json['x'].toDouble() : json['x'],
        this.y = json['y'] is int ? json['y'].toDouble() : json['y'];
}
