import 'package:concordia_navigation/models/course.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Course model', () {
    test('course attributes are set properly', () {
      Course course = Course.fromJson({
        'summary': 'Test course',
        'description': 'Test description',
        'start': {'dateTime': '2020-03-18T11:45:00-04:00'},
        'end': {'dateTime': '2020-03-18T11:45:00-04:00'},
        'location': 'H420'
      });
      expect(course.summary, 'Test course');
      expect(course.description, 'Test description');
      expect(course.start, DateTime.parse('2020-03-18T11:45:00-04:00'));
      expect(course.end, DateTime.parse('2020-03-18T11:45:00-04:00'));
      expect(course.location, 'H420');
      expect(course.filteredLocation(), 'H420');
    });
    test('course with no duration should have 0 as duration property', () {
      Course course = Course.fromJson({
        'summary': 'Test course',
        'description': 'Test description',
        'start': {'dateTime': '2020-03-18T11:45:00-04:00'},
        'end': {'dateTime': '2020-03-18T11:45:00-04:00'},
        'location': 'H420'
      });
      expect(course.duration, 0);
    });
    test('Course with a 90-minute duration should have a 90-min duration property', () {
      Course course = Course.fromJson({
        'summary': 'Test course',
        'description': 'Test description',
        'start': {'dateTime': '2020-03-18T11:45:00-04:00'},
        'end': {'dateTime': '2020-03-18T13:15:00-04:00'},
        'location': 'H420'
      });
      expect(course.duration, 90);
    });
    test('Course with a 120-minute duration should have a 120-min duration property', () {
      Course course = Course.fromJson({
        'summary': 'Test course',
        'description': 'Test description',
        'start': {'dateTime': '2020-03-18T11:45:00-04:00'},
        'end': {'dateTime': '2020-03-18T13:45:00-04:00'},
        'location': 'H420'
      });
      expect(course.duration, 120);
    });
  });
}
