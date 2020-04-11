import 'package:concordia_navigation/models/schedule.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
      DateTime event;
      DateTime current; 
  group('Schedule', () {
    test('returns false if it is saturday and event is friday', () {
      // saturday 8:00AM - beginning of new school week
      current = DateTime(2020, 4, 4, 8);
      
      // friday 8:00AM - end of last school week
      event = DateTime(2020, 4, 3, 8);
      
      expect(Schedule.isThisWeek(event, current), false);
    });

    test('returns false if it is friday and event is saturday', () {
      // saturday 8:00AM - beginning of new school week
      event = DateTime(2020, 4, 4, 5);
      
      // friday 8:00AM - end of last school week
      current = DateTime(2020, 4, 3, 5);
      
      expect(Schedule.isThisWeek(event, current), false);
    });

    test('returns false if it is friday at 11:59 and event is friday', () {
      // thursday 12:01AM - beginning of new school week
      event = DateTime(2020, 4, 2, 0, 1);
      
      // friday 23:59PM - end of last school week
      current = DateTime(2020, 4, 3, 23, 59);
      
      expect(Schedule.isThisWeek(event, current), true);
    });

    test('returns true if event is now', () {
      current = DateTime.now();
      
      expect(Schedule.isThisWeek(current, null), true);
    });
  });
}
