import 'package:concordia_navigation/models/building.dart';
import 'package:concordia_navigation/services/size_config.dart';
import 'package:concordia_navigation/widgets/bottomsheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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

      final testWidget = MediaQuery(
          data: new MediaQueryData(),
          child: MaterialApp(
            home: Scaffold(
              body: TestWidget(buildingInformation)
            ),
          ));

      await tester.pumpWidget(testWidget);

      await tester.pumpAndSettle();
      final campusName = find.text("Directions");
      expect(campusName, findsOneWidget);
    });
  });
}

class TestWidget extends StatelessWidget {
  Building buildingInformation;

  TestWidget(this.buildingInformation);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BottomSheetWidget(this.buildingInformation);
  }
}
