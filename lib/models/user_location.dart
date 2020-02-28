
class UserLocation {
  final double latitude;
  final double longitude;

  UserLocation(this.latitude, this.longitude);

  factory UserLocation.SGW() {
    return UserLocation(45.495944, -73.578075);
  }

  factory UserLocation.LOYOLA() {
    return UserLocation(45.4582, -73.6405);
  }

}