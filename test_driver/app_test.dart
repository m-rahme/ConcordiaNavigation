import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  Future delay([int milliseconds = 100]) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }
  group('App System Integration Test', () {
     FlutterDriver driver;

    setUpAll(() async {

      // Make sure environment variable ANDROID_SDK_ROOT is set to path to Android sdk folder
      final Map<String, String> envVars = Platform.environment;
      final String root = envVars['ANDROID_SDK_ROOT'] ?? envVars['ANDROID_HOME'];
      final String adbPath = root + '/platform-tools/adb.exe';
      await Process.run(adbPath , ['shell' ,'pm', 'grant', 'com.michelrahme.concordia_navigation', 'android.permission.ACCESS_COARSE_LOCATION']);
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('open drawer menu', () async {
      final SerializableFinder drawerMenu = find.byTooltip('Open navigation menu');
      await driver.tap(drawerMenu);
      await driver.scroll(drawerMenu, -300.0, 0.0, const Duration(milliseconds: 300));
    },
    timeout: Timeout(
        Duration(minutes: 1),
      ),
    );
  });

  
}