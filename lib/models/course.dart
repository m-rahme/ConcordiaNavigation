/// This class models a course provided by Google Calendar.
class Course {
  String _summary, _description;
  DateTime _start, _end;

  int duration() => _end.minute - _start.minute;

  String get summary => _summary;
  String get description => _description;
  DateTime get start => _start;
  DateTime get end => _end;

  Course.fromJson(Map<String, dynamic> json)
      : _summary = json['summary'],
        _description = json['description'],
        _start = DateTime.parse(json['start']['dateTime']),
        _end = DateTime.parse(json['end']['dateTime']);
}
