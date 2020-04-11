import 'package:device_calendar/device_calendar.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;

/// This class models a course provided by Google Calendar.
class Course {
  String _summary, _description;
  DateTime _start, _end;
  String _location;

  // duration in minutes
  int get duration => start.difference(_end).inMinutes.abs();

  String get summary => _summary;
  String get description => _description;
  DateTime get start => _start;
  DateTime get end => _end;
  String get location => _location;

  Course.fromJson(Map<String, dynamic> json)
      : _summary = json['summary'],
        _description = json['description'],
        _start = DateTime.parse(json['start']['dateTime']),
        _end = DateTime.parse(json['end']['dateTime']),
        _location = json['location'];

  Course.fromEvent(Event event)
      : _summary = event.title,
        _description = event.description,
        _start = event.start,
        _end = event.end,
        _location = event.location;

  /// Returns whether this location is supported.
  bool hasClassroomLocation() => constants.classroomFilter.hasMatch(_location);

  /// Returns the uppercase filtered location, according to the regex in the constants file.
  /// The filtered location is N/A if location is null, a null string or unsupported.
  String filteredLocation() => _location != null && _location != '' && hasClassroomLocation()
      ? constants.classroomFilter.firstMatch(_location)[0].toUpperCase()
      : 'N/A';
}
