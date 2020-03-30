import 'package:concordia_navigation/models/course.dart';
import 'package:device_calendar/device_calendar.dart';

class Schedule {
  List<Course> _courses;
  String _summary;
  String _tz;

  List<Course> get courses => _courses;

  String get summary => _summary;
  String get tz => _tz;

  Schedule.fromJson(Map<String, dynamic> json)
      : _summary = json['summary'],
        _tz = json['timeZone'],
        _courses =
            json['items'].map<Course>((json) => Course.fromJson(json)).toList();

  Schedule.fromEvents(List<Event> events)
      : _summary = 'All Classes',
        _tz = 'America/Toronto',
        _courses =
            events.map<Course>((event) => Course.fromEvent(event)).toList();

  /// return a list of future classes starting from now until X days into the future
  List<Course> nextClasses({days: 7}) {
    DateTime now = DateTime.now();
    return _courses
        .where((course) =>
            course.start.isAfter(now) &&
            course.end.isBefore(now.add(Duration(days: days))))
        ?.toList();
  }

  /// This returns a list w/ index from 0-4 representing the course on that day of the week.
  /// We're using indexes instead of string values for week days due to multilingual support.
  List<Iterable<Course>> byWeekday() =>
      List.from([byDay(1), byDay(2), byDay(3), byDay(4), byDay(5)]);

  /// Returns a list containing courses for a single day.
  Iterable<Course> byDay(int day) => _courses
      .where(
          (course) => course.start.weekday == day && _isThisWeek(course.start))
      .toList();

  /// returns true if [Schedule.isoWeekNumber(when)] is the same when called with now().
  ///
  /// Weeks start on Saturday and end on Friday.
  ///
  /// A course on Friday, March 27 2020 is not in the same week
  /// as a course on Saturday, March 28 2020.
  bool _isThisWeek(DateTime when) {
    DateTime now = DateTime.now();

    DateTime lastSaturday = now;
    DateTime nextFriday = now;
    int diff = now.weekday;

    if (diff < 6) {
      diff += 7;
    }

    lastSaturday = now.subtract(Duration(days: diff % 6));

    if (now.weekday < 5) {
      nextFriday = now.add(Duration(days: 5 - now.weekday));
    } else if (now.weekday == 6) {
      nextFriday = now.subtract(Duration(days: 1));
    } else {
      nextFriday = now.add(Duration(days: 5));
    }

    return when.isAfter(lastSaturday) && when.isBefore(nextFriday);
  }
}
