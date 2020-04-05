import 'package:concordia_navigation/services/shuttle_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('ShuttleService', () {
    setUpAll(() async {
      ShuttleService.shuttleSchedule = await ShuttleService.loadJson();
    });
    /**
     * Loyola
     */
    test(
        'getNextShuttle() returns string with next loyola shuttle at 7am Monday',
        () async {
      DateTime time = new DateTime(2020, 1, 6, 7);
      String data = ShuttleService.getNextShuttle("loyola", time);
      expect(data, "Next Shuttle Bus at: 07:30");
    });

    test(
        'getNextShuttle() returns string with next loyola shuttle at 11:31pm Monday',
        () async {
      DateTime time = new DateTime(2020, 1, 6, 23, 31);
      String data = ShuttleService.getNextShuttle("loyola", time);
      expect(data, "Next Shuttle Bus at: 07:30");
    });

    test(
        'getNextShuttle() returns string with next loyola shuttle at 11:31pm Thursday',
        () async {
      DateTime time = new DateTime(2020, 1, 9, 23, 31);
      String data = ShuttleService.getNextShuttle("loyola", time);
      expect(data, "Next Shuttle Bus at: 07:40");
    });

    test(
        'getNextShuttle() returns string with next loyola shuttle at 9:51pm Friday',
        () async {
      DateTime time = new DateTime(2020, 1, 10, 21, 51);
      String data = ShuttleService.getNextShuttle("loyola", time);
      expect(data, "Next Shuttle Bus at: 07:30");
    });

    /**
     * SGW
     */
    test('getNextShuttle() returns string with next sgw shuttle at 7am Monday',
        () async {
      DateTime time = new DateTime(2020, 1, 6, 7);
      String data = ShuttleService.getNextShuttle("sgw", time);
      expect(data, "Next Shuttle Bus at: 07:45");
    });

    test(
        'getNextShuttle() returns string with next sgw shuttle at 11:01pm Monday',
        () async {
      DateTime time = new DateTime(2020, 1, 6, 23, 01);
      String data = ShuttleService.getNextShuttle("sgw", time);
      expect(data, "Next Shuttle Bus at: 07:45");
    });

    test(
        'getNextShuttle() returns string with next sgw shuttle at 11:01pm Thursday',
        () async {
      DateTime time = new DateTime(2020, 1, 9, 23, 01);
      String data = ShuttleService.getNextShuttle("sgw", time);
      expect(data, "Next Shuttle Bus at: 07:45");
    });

    test(
        'getNextShuttle() returns string with next sgw shuttle at 9:51pm Friday',
        () async {
      DateTime time = new DateTime(2020, 1, 10, 21, 51);
      String data = ShuttleService.getNextShuttle("sgw", time);
      expect(data, "Next Shuttle Bus at: 07:45");
    });
  });
}
