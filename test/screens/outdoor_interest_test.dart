import 'package:concordia_navigation/screens/outdoor_interest.dart';
import 'package:concordia_navigation/services/outdoor_poi_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../app_widget.dart';

void main() {

  setUp( () async {
      OutdoorPOIList.poi = await OutdoorPOIList.loadJson();
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
