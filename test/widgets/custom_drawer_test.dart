import 'package:concordia_navigation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../app_widget.dart';

void main() {
  group('Custom Drawer', () {
    testWidgets('slides custom drawer open', (WidgetTester tester) async {
      await tester.pumpWidget(appWidget);

      // Wait for LocalizationsDelegate's futures
      await tester.pumpAndSettle();

      await tester.dragFrom(
          tester.getTopLeft(find.byType(MaterialApp)), Offset(300, 0));
      await tester.pumpAndSettle();
      final drawerTitle = find.byType(CustomDrawer);
      expect(drawerTitle, findsOneWidget);
    });
  });
}
