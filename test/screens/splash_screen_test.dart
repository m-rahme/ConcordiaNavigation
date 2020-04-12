import 'package:concordia_navigation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../app_widget.dart';

void main() {
  group('SplashScreen', () {
    testWidgets('displays logo', (WidgetTester tester) async {
      await tester.pumpWidget(appWidget(testWidget: SplashScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(Image), findsNWidgets(2));
    });

  });
}
