import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/models/outdoor/building.dart';
import 'package:concordia_navigation/models/outdoor/university.dart';
import 'package:concordia_navigation/services/indoor/dijkstra.dart';
import 'package:concordia_navigation/services/outdoor/shuttle_service.dart';
import 'package:concordia_navigation/services/outdoor_poi_list.dart';
import 'package:concordia_navigation/services/search.dart';
import 'package:concordia_navigation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../app_widget.dart';

void main() {

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
  group('Custom Drawer', () {
    testWidgets('slides custom drawer open', (WidgetTester tester) async {
      await tester.pumpWidget(appWidget());

      // Wait for LocalizationsDelegate's futures
      await tester.pumpAndSettle();

      await tester.dragFrom(
          tester.getTopLeft(find.byType(MaterialApp)), Offset(300, 0));
      await tester.pumpAndSettle();
      final drawerTitle = find.byType(CustomDrawer);
      expect(drawerTitle, findsOneWidget);
    });
  });
}
