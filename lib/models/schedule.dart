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
    return _courses.where(
      (course) => course.start.isAfter(now)
          && course.end.isBefore(now.add(Duration(days: days)))
    )?.toList();
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
  /// Weeks start on Monday and end on Sunday.
  ///
  /// A course on Monday, March 23 2020 is not in the same week
  /// as a course on Sunday, March 22 2020.
  bool _isThisWeek(DateTime when) =>
      _isoWeekNumber(DateTime.now()) == _isoWeekNumber(when);

  /// https://stackoverflow.com/a/59693145/12964166
  int _isoWeekNumber(DateTime date) {
    int daysToAdd = DateTime.thursday - date.weekday;
    DateTime thursdayDate = daysToAdd > 0
        ? date.add(Duration(days: daysToAdd))
        : date.subtract(Duration(days: daysToAdd.abs()));
    int dayOfYearThursday = _dayOfYear(thursdayDate);
    return 1 + ((dayOfYearThursday - 1) / 7).floor();
  }

  /// https://stackoverflow.com/a/59693145/12964166
  int _dayOfYear(DateTime date) {
    return date.difference(DateTime(date.year, 1, 1)).inDays;
  }
}
