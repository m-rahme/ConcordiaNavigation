import 'dart:convert';
import 'package:concordia_navigation/models/course.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Course', () {
    Course course;
    Map<String, dynamic> jsonObject;

    test('constructor Course.fromJson creates an instance using JSON with correct attributes', () {
      String rawJson = '''{
                              "summary": "SUMMARY",
                              "description": "DESCRIPTION",
                              "start": {
                                  "dateTime": "2020-01-01 20:20:20Z"
                              },
                              "end": {
                                  "dateTime": "2020-01-01 21:20:20Z"
                              },
                              "location": "LOCATION"
                              }''';  
      jsonObject = json.decode(rawJson);

      // Create Course using JSON object
      course = Course.fromJson(jsonObject);
      expect(course, isA<Course>());

      // Check attributes
      expect(course.summary, jsonObject["summary"]);
      expect(course.description, jsonObject["description"]);
      expect(course.start, DateTime.parse(jsonObject["start"]["dateTime"]) );
      expect(course.end, DateTime.parse(jsonObject["end"]["dateTime"]) );
      expect(course.location, jsonObject["location"]);
    });
    test('duration return duration in minutes of Course', () {
      int jsonObjectDuration = 60;
      expect(course.duration, jsonObjectDuration);
    });
    test('constructor Course.fromJson creates an instance using JSON', () {
      // Create Event
      Event event = Event("CALENDARID",
      eventId: "EVENTID",
      title: "TITLE",
      description: "DESCRIPTION",
      start: DateTime(2020, 1, 1, 10, 30),
      end: DateTime(2020, 1, 1, 12, 30),
      );
      event.location = "LOCATION";

      // Create Course from Event
      Course course = Course.fromEvent(event);
      expect(course, isA<Course>());

      // Check attributes
      expect(course.summary, event.title);
      expect(course.description, event.description);
      expect(course.start, event.start);
      expect(course.end, event.end);
      expect(course.location, event.location);
    });

    test('filteredLocation() returns N/A when location does not match the classroomFilter regex', () {
      expect(course.filteredLocation(), 'N/A');
    });
  });

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