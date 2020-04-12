import 'package:concordia_navigation/models/calendar/schedule.dart';
import 'package:concordia_navigation/providers/calendar_data.dart';
import 'package:concordia_navigation/screens/course_schedule.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../app_widget.dart';

class MockCalendarData extends Mock implements CalendarData{
  Future<Schedule> retrieveFromDevice() => null;
}

void main() {
  group('CourseSchedule', () {
    MockCalendarData mockCalendarData = new MockCalendarData();
    Schedule schedule;
    DateTime start;
    DateTime end;
    DateTime now;

    

    setUp(() {
      start = DateTime(2020, 1, 1, 10, 30);
      end = DateTime(2020, 1, 1, 11, 30);
      now = DateTime(2020, 1, 1);
      schedule = Schedule.fromJson({
                  'summary': 'Schedule summary',
                  'timeZone': 'America/Toronto',
                  'items': [
                    {
                      'summary': 'Test course',
                      'description': 'Test description',
                      'start': {'dateTime': start.toString()},
                      'end': {'dateTime': end.toString()},
                      'location': 'H420'
                    }
                  ]
                  });
      when(mockCalendarData.schedule).thenReturn(schedule);
    });
    testWidgets('course is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(appWidget(mockCalendarData: mockCalendarData, testWidget: CourseSchedule(now: now,)));
      await tester.pumpAndSettle();

      final weekday = find.text("Wednesday");
      final courseLocation = find.text("Test course");
      expect(weekday, findsOneWidget);
      expect(courseLocation, findsOneWidget);
    });
  });
}