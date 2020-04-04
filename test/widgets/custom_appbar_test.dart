import 'package:concordia_navigation/services/building_list.dart';
import 'package:flutter_test/flutter_test.dart';
import '../app_widget.dart';

void main() {

  setUp(() async {
    BuildingList.buildingInfo = await BuildingList.loadJson();
  });
  group('Custom Appbar', () {
    testWidgets('finds text widget with name of app', (WidgetTester tester) async {
      await tester.pumpWidget(appWidget());

      // Wait for LocalizationsDelegate's futures
      await tester.pumpAndSettle();

      final appBarTitle = find.text('ConNavigation');
      expect(appBarTitle, findsOneWidget);
    });
  });
  
}
