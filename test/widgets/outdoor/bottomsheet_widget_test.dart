import 'package:concordia_navigation/models/outdoor/building.dart';
import 'package:concordia_navigation/widgets/outdoor/bottomsheet_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../app_widget.dart';

void main() {
  group('BottomSheetWidget', () {
    testWidgets('creates bottom sheet with BuildingInformation',
        (WidgetTester tester) async {
      Building buildingInformation = Building.forTesting("buildingName", "address123", 90.0, 90.0);

      await tester.pumpWidget(appWidget(testWidget: BottomSheetWidget(buildingInformation)));

      await tester.pumpAndSettle();
      final campusName = find.text("address123");
      expect(campusName, findsOneWidget);
    });
  });
}
