import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'app_widget.dart';


// TODO: Update this test once each screen have been implemented
void main() {
  openDrawer(WidgetTester tester) async {
    await tester.dragFrom(
        tester.getTopLeft(find.byType(MaterialApp)), Offset(300, 0));
    await tester.pumpAndSettle();
  }

  verifyScreen(WidgetTester tester, String name) async {
    final finder = find.text(name);
    await tester.tap(finder);
    await tester.pumpAndSettle();
    final btn = find.byType(RaisedButton);
    expect(btn, findsOneWidget);
    await tester.tap(btn);
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    await openDrawer(tester);
  }

  group('App Widget Test', () {
    testWidgets('open drawer', (WidgetTester tester) async {
      await tester.pumpWidget(appWidget);

      // Wait for LocalizationsDelegate's futures
      await tester.pumpAndSettle();

      // Open drawer
      await openDrawer(tester);

      // Verify
      final campus = find.text("Campus");
      expect(campus, findsOneWidget);

      await tester.tap(campus);
      await tester.pumpAndSettle();

      final sgw = find.text("Sir George Williams");
      expect(sgw, findsOneWidget);

      final loyola = find.text("Loyola");
      expect(loyola, findsOneWidget);

      // Verify each screens
      await verifyScreen(tester, "Schedule");
      await verifyScreen(tester, "Outdoor Interest");
      await verifyScreen(tester, "Profile");
      await verifyScreen(tester, "Settings");
    });
  });
}
