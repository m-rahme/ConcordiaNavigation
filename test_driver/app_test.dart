import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  ///Functions
  Future delay([int milliseconds = 100]) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  Future tap(FlutterDriver driver, SerializableFinder finder) async {
    await driver.tap(finder);
    await delay(500);
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
   * Start Automated Tests
   */
  group('App System Integration Test', () {
    FlutterDriver driver;

    /// Finders
    final search = find.byValueKey('LocationSearch');
    final location1 = find.byValueKey('Location1');
    final direction1 = find.byValueKey('Direction1');
    final driving = find.byValueKey('Driving');
    final transit = find.byValueKey('Transit');
    final walking = find.byValueKey('Walking');
    final bicycling = find.byValueKey('Bicycling');
    final viewSchedule = find.byValueKey('ViewSchedule');

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
      await Process.run(adbPath, [
        'shell',
        'pm',
        'grant',
        'com.michelrahme.concordia_navigation',
        'android.permission.READ_CALENDAR'
      ]);
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    /**
     * Run Tests
     */
    test(
      'open drawer menu',
      () async {
        // Open drawer menu
        final SerializableFinder drawerMenu =
            find.byTooltip('Open navigation menu');
        await tap(driver, drawerMenu);

        // Close drawer menu
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
        await snapshot(driver, '\\MapLocation\\1');

        // Toggle campus building hightlights
        await tap(driver, swapCampusIcon);
        await snapshot(driver, '\\MapLocation\\2');
        await tap(driver, sun);
        await snapshot(driver, '\\MapLocation\\3');
        await tap(driver, sun);
        await tap(driver, swapCampusIcon);
        await snapshot(driver, '\\MapLocation\\4');
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );

    test(
      'get directions',
      () async {
        // Open search location page
        await tap(driver, search);
        await snapshot(driver, '\\Directions\\1');

        // Tap second suggested location
        await tap(driver, location1);
        await delay(3000);

        // Slide open directions drawer
        await driver.scroll(
            driving, 0.0, -500.0, const Duration(milliseconds: 800));

        // Go through modes and expect at least first direction tile
        await snapshot(driver, '\\Directions\\driving');
        await driver.waitFor(direction1, timeout: Duration(seconds: 5));
        await tap(driver, transit);

        await snapshot(driver, '\\Directions\\transit');
        await driver.waitFor(direction1, timeout: Duration(seconds: 5));

        await tap(driver, walking);
        await snapshot(driver, '\\Directions\\walking');
        await driver.waitFor(direction1, timeout: Duration(seconds: 5));

        await tap(driver, bicycling);
        await snapshot(driver, '\\Directions\\bicycling');
        await driver.waitFor(direction1, timeout: Duration(seconds: 5));

        // Close directions drawer
        await driver.scroll(
            driving, 0.0, 500.0, const Duration(milliseconds: 800));
        await snapshot(driver, '\\Directions\\mapDirections');
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );

    test(
      'view schedule from directions drawer',
      () async {
        // Slide open directions drawer
        await driver.scroll(
            driving, 0.0, -500.0, const Duration(milliseconds: 800));

        // Open shuttle schedule page
        await tap(driver, viewSchedule);
        await snapshot(driver, '\\ShuttleSchedule\\1');

        // Back
        await driver.tap(find.byTooltip('Back'));
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );
  });
}
