
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../app_widget.dart';


void main() {
  group('LocationSearch', () {
    testWidgets('opens page for searching locations.',
        (WidgetTester tester) async {
      await tester.pumpWidget(appWidget());

      // Wait for LocalizationsDelegate's futures
      await tester.pumpAndSettle();

      // Tap search icon in app bar
      final search = find.byIcon(Icons.search);
      await tester.tap(search);
      await tester.pumpAndSettle();

      // Find list of suggested locations
      final icon = find.byIcon(Icons.location_city);
      expect(icon, findsWidgets);

      // Try text field
      final query = find.byType(TextField);
      await tester.enterText(query, "concordia");
      final concordiaText = find.text("concordia");
      expect(concordiaText, findsOneWidget);

      // Try clearing text field
      final clear = find.byIcon(Icons.clear);
      await tester.tap(clear);
      await tester.pumpAndSettle();
      expect(concordiaText, findsNothing);

      // Go back to homepage
      final backBtn = find.byType(AnimatedIcon);
      await tester.tap(backBtn);
      await tester.pumpAndSettle();
      expect(icon, findsNothing);

    });
  });
}