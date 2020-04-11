import 'package:concordia_navigation/models/building.dart';
import 'package:concordia_navigation/services/size_config.dart';
import 'package:concordia_navigation/widgets/bottomsheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../app_widget.dart';

void main() {
  group('BottomSheetWidget', () {
    testWidgets('creates bottom sheet with BuildingInformation',
        (WidgetTester tester) async {
      Building buildingInformation = Building(
        campusName: "campusName",
        buildingName: "buildingName",
        buildingInitial: "buildingInitial",
        buildingAddress: "buildingAddress",
        latitude: 90.0,
        longitude: 90.0,
        filename: "filename",
      );

      await tester.pumpWidget(appWidget(testWidget: BottomSheetWidget(buildingInformation)));

      await tester.pumpAndSettle();
      final campusName = find.text("Directions");
      final address = find.text(buildingInformation.buildingAddress);
      expect(campusName, findsOneWidget);
      expect(address, findsOneWidget);
    });
  });
}
