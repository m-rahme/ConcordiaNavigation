import 'package:concordia_navigation/models/course.dart';

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

  /// This returns a list w/ index from 0-4 representing the course on that day of the week.
  /// We're using indexes instead of string values for week days due to multilingual support.
  List<Iterable> byWeekday() => [
        _courses.where(
            (course) => course.start.weekday == 1 && isThisWeek(course.start)),
        _courses.where(
            (course) => course.start.weekday == 2 && isThisWeek(course.start)),
        _courses.where(
            (course) => course.start.weekday == 3 && isThisWeek(course.start)),
        _courses.where(
            (course) => course.start.weekday == 4 && isThisWeek(course.start)),
        _courses.where(
            (course) => course.start.weekday == 5 && isThisWeek(course.start)),
      ];

  /// returns true if [Schedule.isoWeekNumber(when)] is the same when called with now().
  ///
  /// Weeks start on Monday and end on Sunday.
  ///
  /// A course on Monday, March 23 2020 is not in the same week
  /// as a course on Sunday, March 22 2020.
  bool isThisWeek(DateTime when) =>
      isoWeekNumber(DateTime.now()) == isoWeekNumber(when);

  /// https://stackoverflow.com/a/59693145/12964166
  int isoWeekNumber(DateTime date) {
    int daysToAdd = DateTime.thursday - date.weekday;
    DateTime thursdayDate = daysToAdd > 0
        ? date.add(Duration(days: daysToAdd))
        : date.subtract(Duration(days: daysToAdd.abs()));
    int dayOfYearThursday = dayOfYear(thursdayDate);
    return 1 + ((dayOfYearThursday - 1) / 7).floor();
  }

  /// https://stackoverflow.com/a/59693145/12964166
  int dayOfYear(DateTime date) {
    return date.difference(DateTime(date.year, 1, 1)).inDays;
  }
}
