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
    await delay(500);
  }

  Future snapshot(FlutterDriver driver, String screenshotName) async {
    await driver.waitUntilNoTransientCallbacks();
    final List<int> pixels = await driver.screenshot();
    File file =
        await new File('.\\test_driver\\screenshots\\$screenshotName.png')
            .create(recursive: true);
    await file.writeAsBytes(pixels);
  }


  /**
   * Start Automated Tests
   */
  group('App System Integration Test', () {
    FlutterDriver driver;
    /// Finders
        final search = find.byValueKey('LocationSearch');
        final indoor = find.byValueKey('Indoor');
        final startLocation = find.byValueKey('StartLocation');
        final endLocation = find.byValueKey('EndLocation');
        final direction0 = find.byValueKey('Direction0');
        final location0 = find.byValueKey('Location0');
        final wheelchair = find.byValueKey('Wheelchair');
        final driving = find.byValueKey('Driving');
        final transit = find.byValueKey('Transit');
        final walking = find.byValueKey('Walking');
        final bicycling = find.byValueKey('Bicycling');
        final viewSchedule = find.byValueKey('ViewSchedule');
        final swapCampusIcon = find.byValueKey('SwitchCampus');
        final sgwTab = find.byValueKey('SGWTab');
        final loyolaTab = find.byValueKey('LoyolaTab');
        final outdoorInterest = find.byValueKey('OutdoorInterest');
        final card = find.byType('Card');



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
      '[open drawer menu and outdoor interest page]',
      () async {
        // Open drawer menu
        final SerializableFinder drawerMenu =
            find.byTooltip('Open navigation menu');
        await tap(driver, drawerMenu);

        // Open outdoor interest page
        await tap(driver, outdoorInterest);

        // SGW tab
        await tap(driver, sgwTab);
        await driver.waitFor(card);
        await delay(1000);
        await snapshot(driver, '\\OutdoorInterest\\SGW');

        // Loyola tab
        await tap(driver, loyolaTab);
        await driver.waitFor(card);
        await delay(1000);
        await snapshot(driver, '\\OutdoorInterest\\Loyola');
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );

    test(
      '[see current location and campus building highlights]',
      () async {
        // Back
        await driver.tap(find.byTooltip('Back'));

        await snapshot(driver, '\\MapLocation\\1');
        await tap(driver, swapCampusIcon);
        await snapshot(driver, '\\MapLocation\\2');
        await tap(driver, swapCampusIcon);
        await snapshot(driver, '\\MapLocation\\3');
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );

    test(
      '[get outdoor directions]',
      () async {
        // Open directions panel
        await tap(driver, search);

        // Pick start and end locations
        await tap(driver, startLocation);
        await delay(1000);
        await driver.enterText("CENTRAL");
        await delay(1000);
        await tap(driver, location0 );

        await tap(driver, endLocation);
        await delay(1000);
        await driver.enterText("H913");
        await delay(1000);
        await tap(driver, location0 );

        // Wait to load
        await delay(2000);
        await snapshot(driver, '\\Directions\\DirectionsPanel');

        // Go through modes and expect at least first direction tile
        await tap(driver, driving);
        await snapshot(driver, '\\Directions\\driving');
        await driver.waitFor(direction0, timeout: Duration(seconds: 5));
        
        await tap(driver, transit);
        await snapshot(driver, '\\Directions\\transit');
        await driver.waitFor(direction0, timeout: Duration(seconds: 5));

        await tap(driver, walking);
        await snapshot(driver, '\\Directions\\walking');
        await driver.waitFor(direction0, timeout: Duration(seconds: 5));

        await tap(driver, bicycling);
        await snapshot(driver, '\\Directions\\bicycling');
        await driver.waitFor(direction0, timeout: Duration(seconds: 5));

        // Close directions drawer
        await driver.scroll(
            driving, 0.0, 500.0, const Duration(milliseconds: 800));
        await snapshot(driver, '\\Directions\\mapDirections');

        // Check path on map
        await tap(driver, swapCampusIcon);
        await delay(1000);
        await tap(driver, swapCampusIcon);
        await delay(1000);
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );

    test(
      '[get indoor directions]',
      () async {
        final h1 = find.byValueKey("Indoor0");
        final h8 = find.byValueKey("Indoor1");
        final h9 = find.byValueKey("Indoor2");
        final mb1 = find.byValueKey("Indoor3");

        // View each floor
        await tap(driver, indoor);
        await delay(2000);
        await tap(driver, h1);
        await delay(2000);
        await tap(driver, h8);
        await delay(2000);
        await tap(driver, h9);
        await delay(2000);
        await tap(driver, mb1);
        await delay(2000);

        // Back
        await driver.tap(find.byTooltip('Back'));
        await delay(1500);
        await driver.tap(wheelchair);

        // View accessibility
        await delay(1000);
        await tap(driver, indoor);
        await tap(driver, h1);
        await delay(2000);
        await tap(driver, h8);
        await delay(2000);
        await tap(driver, h9);
        await delay(2000);
        await tap(driver, mb1);
        await delay(2000);
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );

    test(
      '[view schedule from directions drawer]',
      () async {
        // Back
        await driver.tap(find.byTooltip('Back'));

        // Slide open directions drawer
        await driver.scroll(
            driving, 0.0, -500.0, const Duration(milliseconds: 800));

        // Open shuttle schedule page
        await tap(driver, viewSchedule);
        await driver.waitFor(find.text("09:30"));
        await snapshot(driver, '\\ShuttleSchedule\\1');

        // Back
        await driver.tap(find.byTooltip('Back'));

        // Slide close directions drawer
        await driver.scroll(
            driving, 0.0, 500.0, const Duration(milliseconds: 800));
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );

  });
}
