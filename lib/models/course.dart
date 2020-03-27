import 'package:device_calendar/device_calendar.dart';

/// This class models a course provided by Google Calendar.
class Course {
  String _summary, _description;
  DateTime _start, _end;
  String _location;

  int duration() => _end.minute - _start.minute;

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
}
