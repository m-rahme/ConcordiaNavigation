import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;

///Observer Pattern
///This class is used to parse the shuttle schedule JSON and get the next available shuttle bus.
class ShuttleData extends ChangeNotifier {
  static Map schedule;

  ShuttleData();

  Future<String> getNextShuttle(campus, [DateTime time]) async {
    schedule =
        json.decode(await rootBundle.loadString('assets/shuttleSchedule.json'));
    time = time ?? DateTime.now();
    if (time.weekday == 7 ||
        time.weekday == 6 ||
        (time.weekday == 5 && time.hour * 100 > 1950)) {
      return null;
    } else {
      var length = time.weekday == 5
          ? schedule[campus]['5'].length
          : schedule[campus]['1'].length;
      var day = time.weekday.toString();

      String shuttleTime;

      for (var i = 0; i < length; i++) {
        if (int.parse(schedule[campus][day][i]) >=
            (time.hour * 100) + time.minute) {
          shuttleTime = schedule[campus][day][i];
          break;
        }
      }
      var timeList = shuttleTime.split('');
      return "Next Shuttle Bus at: " +
          timeList[0] +
          timeList[1] +
          ":" +
          timeList[2] +
          timeList[3];
    }
  }
}
