import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;

///Observer Pattern
///This class is used to parse the shuttle schedule JSON and get the next available scheduled bus.
class ShuttleData extends ChangeNotifier {
  Map shuttleSchedule;

  ShuttleData() {
    // set schedule whenever rootBundle is done
    rootBundle
        .loadString('assets/shuttleSchedule.json')
        .then((data) => shuttleSchedule = json.decode(data));
  }

  Future<String> getNextShuttle(campus, [DateTime time]) async {
    schedule =
        json.decode(await rootBundle.loadString('assets/shuttleSchedule.json'));
    time = time ?? DateTime.now();
    if (time.weekday == 7 || time.weekday == 6) {
      return null;
    } else {
      var length = time.weekday == 5
          ? shuttleSchedule[campus]['5'].length
          : shuttleSchedule[campus]['1'].length;
      var day = time.weekday.toString();

      String shuttleTime;

      // Find next available shuttleSchedule time on same day
      for (var i = 0; i < length; i++) {
        if (int.parse(shuttleSchedule[campus][day][i].replaceAll(RegExp(r":"), "")) >=
            (time.hour * 100) + time.minute) {
          shuttleTime = shuttleSchedule[campus][day][i];
          break;
        }
      }

      // Get next day's available shuttleSchedule time
      if (shuttleTime == null) {
        int nextAvailableDay =
            (time.weekday + 1) % (shuttleSchedule[campus].length + 1);
        if (nextAvailableDay == 0) nextAvailableDay++;
        shuttleTime = shuttleSchedule[campus][nextAvailableDay.toString()][0];
      }

      return "Next Shuttle Bus at: $shuttleTime";
    }
  }
}
