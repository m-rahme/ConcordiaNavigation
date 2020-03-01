import 'package:flutter_test/flutter_test.dart';
import './test_app_widget.dart';

void main() {
  group('MapWidget', () {
    testWidgets(
        'Map tries to create the map widget but fails because the initial camera location is null',
        (WidgetTester tester) async {
      await tester.pumpWidget(testAppWidget);

      // Wait for LocalizationsDelegate's futures
      await tester.pumpAndSettle();

      expect(find.text('Loading Map'), findsOneWidget);
    });
  });
}
