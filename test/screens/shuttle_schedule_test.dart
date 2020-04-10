import 'package:concordia_navigation/screens/shuttle_schedule.dart';
import 'package:concordia_navigation/services/shuttle_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../app_widget.dart';

void main() {

  setUp( () async {
      ShuttleService.shuttleSchedule = await ShuttleService.loadJson();
  });

  group('ShuttleSchedule', () {
    testWidgets('displays shuttle schedule when ShuttleService.shuttleSchedule is NOT null', (WidgetTester tester) async {
      await tester.pumpWidget(appWidget(testWidget: ShuttleSchedule()));
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text("--:--"), findsWidgets);
    });

    testWidgets('buttons campus to campus toggles booleans', (WidgetTester tester) async {
      await tester.pumpWidget(appWidget(testWidget: ShuttleSchedule()));
      await tester.pumpAndSettle();

      final sgwToLoy = find.byKey(Key("SGWToLoy")); 
      final loyToSGW = find.byKey(Key("LoyToSGW")); 

      await tester.tap(sgwToLoy);
      await tester.tap(loyToSGW);
    });

    testWidgets('displays a circular progress indicator when ShuttleService.shuttleSchedule is null', (WidgetTester tester) async {
      // Set shuttleSchedule to null
      ShuttleService.shuttleSchedule = null;
      await tester.pumpWidget(appWidget(testWidget: ShuttleSchedule()));
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

  });
}
