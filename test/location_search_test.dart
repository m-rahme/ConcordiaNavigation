import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import './test_app_widget.dart';

void main() {
  group('Location Search', () {
    testWidgets('display default search suggestions',
        (WidgetTester tester) async {
      await tester.pumpWidget(testAppWidget);

      // Wait for LocalizationsDelegate's futures
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      expect(find.text("SGW Campus, Montreal"), findsOneWidget);
    });
  });
}
