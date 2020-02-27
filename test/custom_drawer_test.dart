
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import './test_app_widget.dart';

void main() {
  group('Custom Drawer', () {

    testWidgets('CustomDrawer creates Drawer', (WidgetTester tester) async {
      await tester.pumpWidget(testAppWidget);

      // Wait for LocalizationsDelegate's futures
      await tester.pumpAndSettle();

      await tester.dragFrom(tester.getTopLeft(find.byType(MaterialApp)), Offset(300, 0));
      await tester.pumpAndSettle();
      final drawerTitle = find.text('ConNavigator');
      expect(drawerTitle, findsOneWidget);
    });
  });
}
