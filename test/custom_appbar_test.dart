import 'package:flutter_test/flutter_test.dart';
import './test_app_widget.dart';

void main() {
  group('Custom Appbar', () {
    testWidgets('finds text widget with name of app', (WidgetTester tester) async {
      await tester.pumpWidget(testAppWidget);

      // Wait for LocalizationsDelegate's futures
      await tester.pumpAndSettle();

      final appBarTitle = find.text('ConNavigation');
      expect(appBarTitle, findsOneWidget);
    });
  });
}