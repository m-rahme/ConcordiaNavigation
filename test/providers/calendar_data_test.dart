import 'package:collection/collection.dart';
import 'package:concordia_navigation/providers/calendar_data.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:device_calendar/src/models/result.dart';
import 'package:device_calendar/src/models/event.dart';

class MockDeviceCalendarPlugin extends Mock implements DeviceCalendarPlugin{}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('CalendarData', () {
    MockDeviceCalendarPlugin mockDeviceCalendarPlugin;
    Result<bool> permission;

    Result<UnmodifiableListView<Calendar>> resultCalendar;
    List<Calendar> calendars = List();
    Calendar calendar;

    Result<UnmodifiableListView<Event>> resultEvent;
    List<Event> events = List();
    Event event;


    setUpAll(() async {
      const MethodChannel channel = MethodChannel('plugins.builttoroam.com/device_calendar');
      channel.setMockMethodCallHandler((MethodCall methodCall) async {});

      // Permission
      permission = Result<bool>();
      permission.data = true;
      
      // Calendar
      resultCalendar = Result<UnmodifiableListView<Calendar>>();
      calendar = Calendar(
        id: "calendarID", 
        accountName: "accountName", 
        accountType: "accountType",
        color: 1,
        isDefault: true,
        isReadOnly: false
      );
      calendars.add(calendar);
      resultCalendar.data = UnmodifiableListView(calendars);

      // Events
      resultEvent = Result<UnmodifiableListView<Event>>();
      event = Event(
        "calendarID",
        eventId: "eventID",
        allDay: false,
        title: "SOEN390",
        start: DateTime(2020, 01, 01, 10),
        end: DateTime(2020, 01, 01, 11),
      );
      events.add(event);
      resultEvent.data = UnmodifiableListView(events);

      // Mock
      mockDeviceCalendarPlugin = MockDeviceCalendarPlugin();
      when(mockDeviceCalendarPlugin.hasPermissions()).thenAnswer((_) => Future.value(permission) );
      when(mockDeviceCalendarPlugin.retrieveCalendars()).thenAnswer((_) => Future.value(resultCalendar) );
      when(mockDeviceCalendarPlugin.retrieveEvents(any, any)).thenAnswer((_) => Future.value(resultEvent) );
    });


    test(
        'constructor creates a list of Calendar',
        () async {
      CalendarData calendarData = CalendarData(mockDeviceCalendarPlugin, DateTime(2020, 01, 01));
      await calendarData.retrieveFromDevice(DateTime(2020, 01, 01));
      expect(calendarData.schedule.courses[0].summary, event.title);
    });

  });
}
