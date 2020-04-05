class Coordinate {
  double x;
  double y;

  Coordinate.fromJson(Map json)
      : this.x = json['x'] is int ? json['x'].toDouble() : json['x'],
        this.y = json['y'] is int ? json['y'].toDouble() : json['y'];
}
