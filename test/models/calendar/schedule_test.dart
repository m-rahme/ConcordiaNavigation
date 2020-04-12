import 'dart:convert';
import 'package:concordia_navigation/models/calendar/course.dart';
import 'package:concordia_navigation/models/calendar/schedule.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Schedule', () {
    Schedule schedule;
    Map<String, dynamic> jsonCourseObject;
    Map<String, dynamic> jsonScheduleObject;
    DateTime start;
    DateTime end;
    DateTime from;

    setUp(() {
      start = DateTime(2020, 1, 1, 10, 30);
      end = DateTime(2020, 1, 1, 11, 30);
      from = DateTime(2020, 1, 1);

      // Schedule containing a single course
      String rawJsonCourse1 = '''{
                              "summary": "SUMMARY1",
                              "description": "DESCRIPTION1",
                              "start": {
                                  "dateTime": "$start"
                              },
                              "end": {
                                  "dateTime": "$end"
                              },
                              "location": "LOCATION1"
                              }''';  
      String rawJsonSchedule ='''{
                              "summary": "SCHEDULE_SUMMARY",
                              "timeZone": "America/Toronto",
                              "items": [$rawJsonCourse1]
                              }'''; 
      jsonCourseObject = json.decode(rawJsonCourse1);
      jsonScheduleObject = json.decode(rawJsonSchedule);
    });



    test('constructor Schedule.fromJson creates an instance using JSON with correct attributes', () {
      // Create Schedule using JSON object
      schedule = Schedule.fromJson(jsonScheduleObject);
      expect(schedule, isA<Schedule>());

      // Check attributes
      expect(schedule.summary, jsonScheduleObject["summary"]);
      expect(schedule.tz, jsonScheduleObject["timeZone"]);
      expect(schedule.courses.length, 1);
    });

    test('method nextClasses() return list of Courses', () {
      // Get list of Courses
      List<Course> courseList = schedule.nextClasses(from: from);
      expect(courseList.length, 1);
      expect(courseList[0].summary, jsonCourseObject["summary"]);
    });

    test('method byWeekday() returns list of iterable containing Courses for each day of week', () {
      List<Iterable<Course>> weekDayCourses = schedule.byWeekday(from);
      expect(weekDayCourses[from.weekday-1].toList()[0].summary, jsonCourseObject["summary"]);
    });

    test('method _isThisWeek() return true', () {
    });
  });
}
