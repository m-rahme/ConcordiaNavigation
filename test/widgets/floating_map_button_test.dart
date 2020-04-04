import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:concordia_navigation/widgets/floating_map_button.dart';

void main() {
  group('FloatingMapButton', () {
    testWidgets('floating button is created', (WidgetTester tester) async {
      void callback() {}

      final IconData iconData = Icons.swap_calls;

      final floatingMapButton = FloatingMapButton(
        top: 10,
        left: 10,
        icon: Icon(iconData),
        onClick: callback,
        bgColor: Colors.red,
        fgColor: Colors.green,
      );

      final testWidget = MaterialApp(
        home: Scaffold(body: floatingMapButton),
      );

      await tester.pumpWidget(testWidget);

      await tester.pumpAndSettle();
      final btnFinder = find.byWidget(floatingMapButton);
      final iconFinder = find.byIcon(iconData);
      expect(btnFinder, findsOneWidget);
      expect(iconFinder, findsOneWidget);
    });
  });
}
