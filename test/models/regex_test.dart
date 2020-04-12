import 'package:flutter_test/flutter_test.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;

void main() {
  group('Regex matching courses', () {
    RegExp regex = constants.classroomFilter;
    test('simple valid class locations', () {
      expect(regex.hasMatch("H420"), true);
      expect(regex.hasMatch("H 420"), true);
      expect(regex.hasMatch("MB 1.398"), true);
      expect(regex.hasMatch("MB1.398"), true);
      expect(regex.hasMatch("MBS9.398"), true);
      expect(regex.hasMatch("FG B030"), true);
      expect(regex.hasMatch("FG B-030"), true);
    });
    test('simple invalid class locations', () {
      expect(regex.hasMatch("R42"), false);
      expect(regex.hasMatch("B 420"), false);
      expect(regex.hasMatch("MB 0.398"), false);
      expect(regex.hasMatch("MC1.398"), false);
      expect(regex.hasMatch("MB59.398"), false);
      expect(regex.hasMatch("FG B010"), false);
      expect(regex.hasMatch("FG B-010"), false);
    });
    test('embedded valid class locations', () {
      expect(regex.hasMatch("CONCORDIA H420 THING"), true);
      expect(regex.hasMatch("TEST LOCATION H 420TION"), true);
      expect(regex.hasMatch("AMB 1.398CONCORDIA"), true);
      expect(regex.hasMatch("LAMB1.398TEST"), true);
      expect(regex.hasMatch("TEST MBS9.398 TESTEST"), true);
      expect(regex.hasMatch("91839FG B03034840"), true);
      expect(regex.hasMatch("2983ETESFG B-0302983GTES"), true);
    });
    test('embedded invalid class locations', () {
      expect(regex.hasMatch("CONCORDIA C420 THING"), false);
      expect(regex.hasMatch("TEST LOCATION H 20TION"), false);
      expect(regex.hasMatch("AMB 1..398CONCORDIA"), false);
      expect(regex.hasMatch("LAMB11.398TEST"), false);
      expect(regex.hasMatch("TEST MBSS.398 TESTEST"), false);
      expect(regex.hasMatch("91839FGC03034840"), false);
      expect(regex.hasMatch("2983ETESFG  B-0302983GTES"), false);
    });
    test('an invalid class location', () {
      String test = "invalid";
      expect(regex.hasMatch(test), false);
    });
  });
}