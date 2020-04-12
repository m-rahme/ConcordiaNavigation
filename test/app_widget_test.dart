import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/models/outdoor/building.dart';
import 'package:concordia_navigation/models/university.dart';
import 'package:concordia_navigation/services/dijkstra.dart';
import 'package:concordia_navigation/services/outdoor/shuttle_service.dart';
import 'package:concordia_navigation/services/outdoor_poi_list.dart';
import 'package:concordia_navigation/services/search.dart';
import 'package:concordia_navigation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'app_widget.dart';


// TODO: Update this test once each screen have been implemented
void main() {
  /**
   * Open drawer when in homepage
   */
  openDrawer(WidgetTester tester) async {
    await tester.dragFrom(
        tester.getTopLeft(find.byType(MaterialApp)), Offset(300, 0));
    await tester.pumpAndSettle();
  }

  /**
   * 1. Tap finder
   * 2. Tap center button
   * 3. Go back to map
   * 4. Re-open drawer
   */
  verifyScreen(WidgetTester tester, String name) async {
    final finder = find.text(name);
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    await openDrawer(tester);
  }

  group('App Widget Test', () {

    setUp(() async {
      ShuttleService.shuttleSchedule = await ShuttleService.loadJson();
      OutdoorPOIList.poi = await OutdoorPOIList.loadJson();

      List<dynamic> data = await University.loadJson();
      University.concordia = University.fromJson(data);
      Dijkstra.shortest = Dijkstra.fromJson(data);

      Search.supported.forEach((object) {
      if (object is IndoorLocation || object is Building)
        Search.names.add(object.name.toUpperCase());
      });
    });

    testWidgets('open drawer', (WidgetTester tester) async {
      await tester.pumpWidget(appWidget());

      // Wait for LocalizationsDelegate's futures
      await tester.pumpAndSettle();

      // Open drawer
      await openDrawer(tester);

      // Verify campus
      final campus = find.text("Campus");
      expect(campus, findsOneWidget);
      await tester.tap(campus);
      await tester.pumpAndSettle();

      final sgw = find.text("Sir George Williams");
      expect(sgw, findsOneWidget);
      await tester.tap(sgw);
      await tester.pumpAndSettle();
      await openDrawer(tester);
      await tester.tap(campus);
      await tester.pumpAndSettle();

      final loyola = find.text("Loyola");
      expect(loyola, findsOneWidget);
      await tester.tap(loyola);
      await tester.pumpAndSettle();
      await openDrawer(tester);
      await tester.tap(campus);
      await tester.pumpAndSettle();

      // Verify all other screens from drawer
      // await verifyScreen(tester, "Schedule");
      // await verifyScreen(tester, "Outdoor Interest");
      // await verifyScreen(tester, "Profile");
      // await verifyScreen(tester, "Settings");

      // Verify drawer closes by tapping on drawer header
      final drawer = find.byType(CustomDrawer); 
      expect(drawer, findsOneWidget);
      final header = find.text("ConNavigation").at(1);
      await tester.tap(header);
      await tester.pumpAndSettle();
      expect(drawer, findsNothing);
    });
  });
}
