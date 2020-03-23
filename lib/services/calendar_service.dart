import 'package:concordia_navigation/models/course.dart';
import 'package:concordia_navigation/models/schedule.dart';

import 'network.dart';
import 'dart:convert';

// TODO: move this to app_constants
const String apiKey = 'AIzaSyBHXKzGZEeBhP_m3QQ6vpI0hRODxeeEWl0';
const String calId = 'r9cpm71rcvjq91n86ku85ghr18';

class CalendarService {
  /// Requests the JSON from Google's calendar API then builds the Schedule object.
  /// This is a different approach to what is done with directions in that the model is built here.
  ///
  /// Constructs the URL from: premade API key + calendar url
  static Future<Schedule> getSchedule() async {
    String raw = await Network.getData(
        'https://www.googleapis.com/calendar/v3/calendars/${calId}@group.calendar.google.com/events?key=${apiKey}');

    Map<String, dynamic> rawJson = json.decode(raw);
    return Schedule.fromJson(rawJson);
  }
}
