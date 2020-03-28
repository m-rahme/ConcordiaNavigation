import 'dart:convert';

import 'package:concordia_navigation/models/schedule.dart';
import 'package:concordia_navigation/services/network.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/widgets.dart';

class CalendarData extends ChangeNotifier {
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();
  final DeviceCalendarPlugin _deviceCalendarPlugin = new DeviceCalendarPlugin();
  final Duration _lookahead = new Duration(days: 31);
  List<Calendar> _calendars = new List();
  List<Event> _classes = new List();
  List<Event> _classes = List();
  Schedule _schedule;

  Schedule get schedule => _schedule;

  CalendarData() {
    retrieveFromDevice();
  }

  Future<bool> _checkPermission() async {
    var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
    if (permissionsGranted.isSuccess && !permissionsGranted.data) {
      permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
      if (!permissionsGranted.isSuccess || !permissionsGranted.data) {
        throw new Exception('Missing Calendar Permissions');
      }
    }
    return true;
  }

  Future<void> _retrieveDeviceCalendars() async {
    //Retrieve user's calendars from mobile device
    //Request permissions first if they haven't been granted
    try {
      await _checkPermission();

      // Filter to find only school related calendars
      final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
      _calendars = calendarsResult?.data?.where((calendar) => (
          calendar.isReadOnly == false &&
          calendar.name.contains(RegExp("([C|c]onco)|[S|s]chool|[U|u]ni"))
          ))?.toList();
      _calendars = calendarsResult?.data
          ?.where((calendar) => (calendar.isReadOnly == false &&
              calendar.name.toLowerCase().contains(constants.calFilter)))
          ?.toList();
    } catch (e) {
      print(e);
    }
  }

  /// Using device calendars, retrieve relevant events from
  Future<Schedule> retrieveFromDevice() async {
    if (_calendars.isEmpty) {
      await _retrieveDeviceCalendars();
    }

    DateTime now = DateTime.now();
    DateTime _firstDayOfTheweek = now.subtract(Duration(days: now.weekday));

    DateTime _firstDayOfTheweek = now.subtract(new Duration(days: now.weekday));
    RetrieveEventsParams retrieveEventsParams = new RetrieveEventsParams(
        startDate: _firstDayOfTheweek, endDate: now.add(_lookahead));

    List<Event> events = List();

    for (Calendar cal in _calendars) {
      final result = await _deviceCalendarPlugin.retrieveEvents(cal.id, retrieveEventsParams);
      events.addAll(result?.data);
      print(result);
    }

    _classes = events.where((event) => (
      // check title has discipline (4 letters uppercase) followed by a course # (3 digits)
      !event.allDay && event.title.contains(RegExp(r"[A-Z]{4}[-|\s]?\d{3}"))
    ))?.toList();

    _schedule = Schedule.fromEvents(_classes);
    notifyListeners();

    return _schedule;
  }

  /// DEPRECATED
  /// Requests the JSON from Google's calendar API then builds the Schedule object.
  /// This is a different approach to what is done with directions in that the model is built here.
  ///
  /// Constructs the URL from: premade API key + calendar url
  Future<Schedule> retrieveFromGoogle(
      {String apiKey: 'AIzaSyBHXKzGZEeBhP_m3QQ6vpI0hRODxeeEWl0',
      String calId = 'r9cpm71rcvjq91n86ku85ghr18'}) async {
    String raw = await Network.getData(
        'https://www.googleapis.com/calendar/v3/calendars/$calId@group.calendar.google.com/events?key=$apiKey');

    _schedule = Schedule.fromJson(json.decode(raw));
    notifyListeners();

    return _schedule;
  }
}
