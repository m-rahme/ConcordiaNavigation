import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/models/outdoor/building.dart';
import 'package:concordia_navigation/models/university.dart';
import 'package:concordia_navigation/providers/indoor_data.dart';
import 'package:concordia_navigation/services/dijkstra.dart';
import 'package:concordia_navigation/services/search.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('IndoorData', () {
    IndoorData indoorData;

    setUpAll(() async {
      List<dynamic> data = await University.loadJson();
      University.concordia = University.fromJson(data);
      Dijkstra.shortest = Dijkstra.fromJson(data);
      indoorData = new IndoorData();
      Search.supported.forEach((object) {
        if (object is IndoorLocation || object is Building)
          Search.names.add(object.name.toUpperCase());
      });
    });

    test(
        'setItinerary() sets indoorItinerary',
        () {
      expect(indoorData.indoorItinerary, isNull);
      indoorData.setItinerary(start: "H945", end: "H937", accessible: indoorData.wheelchair);
      expect(indoorData.indoorItinerary, isNotNull);
    });

    test(
        'toggleWheelchair() toggles wheelchair bool then invokes setItinerary() when indoorItinerary is NOT null',
        () async {
      expect(indoorData.wheelchair, isFalse);
      await indoorData.toggleWheelchair();
      expect(indoorData.wheelchair, isTrue);
      expect(indoorData.indoorItinerary.accessible, isTrue);
    });

    test(
        'removeItinerary() sets indoorItinerary to null',
        () {
      expect(indoorData.indoorItinerary, isNotNull);
      indoorData.removeItinerary();
      expect(indoorData.indoorItinerary, isNull);
    });

  });
}
