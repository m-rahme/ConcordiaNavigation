import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/models/outdoor/university.dart';
import 'package:concordia_navigation/services/indoor/dijkstra.dart';
import 'package:concordia_navigation/services/outdoor/indoor_itinerary.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('indoor itinerary', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    List data;

    // load reused data
    setUpAll(() async {
      // loads file with data
      data = await University.loadJson();
      // loads data for searching
      University.fromJson(data);
      Dijkstra.shortest = Dijkstra.fromJson(data);
    });
    test('getting an indoor itinerary from H820 to the entrance', () {
      IndoorItinerary h820toh1entrance = IndoorItinerary("H820", "H1entrance");
      bool allIndoorLocations =
          h820toh1entrance.path.every((location) => location is IndoorLocation);
      expect(allIndoorLocations, true);
      expect(h820toh1entrance.path.first.name, "H820");
      expect(h820toh1entrance.path.last.name, "H1entrance");
      expect(h820toh1entrance, isA<IndoorItinerary>());
    });
  });
}
