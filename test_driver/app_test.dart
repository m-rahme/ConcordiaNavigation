import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {

  /**
   * Functions
   */
  Future delay([int milliseconds = 100]) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  Future tap(FlutterDriver driver, SerializableFinder  finder) async {
    await driver.tap(finder);
    await delay(1000);
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


  /**
   * Automated Tests
   */
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
        await tap(driver, drawerMenu);
        await driver.scroll(
            drawerMenu, -300.0, 0.0, const Duration(milliseconds: 500));
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );

    test(
      'see current location and campus building highlights',
      () async {
        final swapCampusIcon = find.byValueKey('SwitchCampus');
        final sun = find.byValueKey('ToggleBuildingHighlight');
        await snapshot(driver, '\\UserStory_1\\1');
        await tap(driver, swapCampusIcon);
        await snapshot(driver, '\\UserStory_1\\2');
        await tap(driver, sun);
        await snapshot(driver, '\\UserStory_1\\3');
        await tap(driver, sun);
        await tap(driver, swapCampusIcon);
        await snapshot(driver, '\\UserStory_1\\4');
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );

     test(
      'get directions',
      () async {

        /// Finders
        final search = find.byValueKey('LocationSearch');
        final swapCampusIcon = find.byValueKey('SwitchCampus');
        final currentLocation = find.byValueKey('CurrentLocation');
        final location1 = find.byValueKey('Location1');
        final driving = find.byValueKey('Driving');
        final transit = find.byValueKey('Transit');
        final walking = find.byValueKey('Walking');
        final bicycling = find.byValueKey('Bicycling');
        final schedule = find.text('SCHEDULE');

        // Tests
        await tap(driver, search);
        await snapshot(driver, '\\Directions\\1');
        await tap(driver, location1);
        await delay(3000);
        await snapshot(driver, '\\Directions\\driving');
        await tap(driver, transit);
        await snapshot(driver, '\\Directions\\transit');
        await tap(driver, walking);
        await snapshot(driver, '\\Directions\\walking');
        await tap(driver, bicycling);
        await snapshot(driver, '\\Directions\\bicycling');
        await driver.scroll(
            schedule, 0.0, 500.0, const Duration(milliseconds: 800));
        await snapshot(driver, '\\Directions\\mapDirections');
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );

  });
}
