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

    test('duration() return duration in minutes of Course', () {
      DateTime start = DateTime.parse(jsonObject["start"]["dateTime"]);
      DateTime end = DateTime.parse(jsonObject["start"]["dateTime"]);
      int jsonObjectDuration = end.minute - start.minute;
      expect(course.duration(), jsonObjectDuration);
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
}
