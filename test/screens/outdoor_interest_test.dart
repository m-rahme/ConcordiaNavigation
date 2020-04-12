import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/models/outdoor/building.dart';
import 'package:concordia_navigation/models/university.dart';
import 'package:concordia_navigation/screens/outdoor_interest.dart';
import 'package:concordia_navigation/services/outdoor/shuttle_service.dart';
import 'package:concordia_navigation/services/outdoor_poi_list.dart';
import 'package:concordia_navigation/services/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../app_widget.dart';

void main() {

  setUp( () async {
    ShuttleService.shuttleSchedule = await ShuttleService.loadJson();
    OutdoorPOIList.poi = await OutdoorPOIList.loadJson();

    List<dynamic> data = await University.loadJson();
    University.concordia = University.fromJson(data);

    Search.supported.forEach((object) {
    if (object is IndoorLocation || object is Building)
      Search.names.add(object.name.toUpperCase());
    });
  });

  group('OutdoorInterest', () {
    testWidgets('displays at least one outdoor interest', (WidgetTester tester) async {
      final tabs = find.byType(Tab);
      final cards = find.byType(Card);

      await tester.pumpWidget(appWidget(testWidget: OutdoorInterest()));
      await tester.pumpAndSettle();

      // Check SGW outdoor interests
      await tester.tap(tabs.at(0));
      await tester.pumpAndSettle();
      expect(cards, findsWidgets);

      // Check Loyola outdoor interests
      await tester.tap(tabs.at(1));
      await tester.pumpAndSettle();
      expect(cards, findsWidgets);
    });

  });
}
