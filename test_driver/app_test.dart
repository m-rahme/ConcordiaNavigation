import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  Future delay([int milliseconds = 100]) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  Future snapshot(FlutterDriver driver, String screenshotName) async {
    await driver.waitUntilNoTransientCallbacks();
    final List<int> pixels = await driver.screenshot();
    File file =
        await new File('.\\test_driver\\screenshots\\$screenshotName.png')
            .create(recursive: true);
    await file.writeAsBytes(pixels);
    print('Screenshot $file');
  }

  group('App System Integration Test', () {
    FlutterDriver driver;

    setUpAll(() async {
      // Make sure environment variable ANDROID_SDK_ROOT is set to path to Android sdk folder
      final Map<String, String> envVars = Platform.environment;
      final String root =
          envVars['ANDROID_SDK_ROOT'] ?? envVars['ANDROID_HOME'];
      final String adbPath = root + '/platform-tools/adb.exe';
      await Process.run(adbPath, [
        'shell',
        'pm',
        'grant',
        'com.michelrahme.concordia_navigation',
        'android.permission.ACCESS_COARSE_LOCATION'
      ]);
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test(
      'open drawer menu',
      () async {
        final SerializableFinder drawerMenu =
            find.byTooltip('Open navigation menu');
        await driver.tap(drawerMenu);
        await driver.scroll(
            drawerMenu, -300.0, 0.0, const Duration(milliseconds: 300));
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );

    test(
      'User Story 1',
      () async {
        delay(2000);
        await snapshot(driver, '\\UserStory_1\\1');
        final swapCampusIcon = find.byValueKey('SwitchCampus');
        await driver.tap(swapCampusIcon);
        await snapshot(driver, '\\UserStory_1\\2');
        await driver.tap(swapCampusIcon);
        await snapshot(driver, '\\UserStory_1\\3');
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );
  });
}
