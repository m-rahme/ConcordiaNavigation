import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class ShuttleData extends ChangeNotifier {
  var _json;

  ShuttleData() {
    readJsonFile();
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/shuttleSchedule.json');
  }

  void readJsonFile() async {
    Future<String> future = loadAsset();
    future.then((value) => loadJson(value));
  }

  void loadJson(response) {
    _json = json.decode(response);
  }

  String getNextShuttle(campus) {
    var now = new DateTime.now();
    if (now.weekday == 7 ||
        now.weekday == 6 ||
        (now.weekday == 5 && now.hour * 100 > 1950)) {
      return "Check Shuttle Schedule for More Info";
    } else {
      var length = now.weekday == 5
          ? _json[campus]['5'].length
          : _json[campus]['1'].length;
      var day = now.weekday.toString();

      String shuttleTime;

      for (var i = 0; i < length; i++) {
        if (int.parse(_json[campus][day][i]) >= (now.hour * 100) + now.minute) {
          shuttleTime = _json[campus][day][i];
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
