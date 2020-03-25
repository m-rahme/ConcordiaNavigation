import 'package:concordia_navigation/models/course.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/services/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:provider/provider.dart';

class Weekday extends StatelessWidget {
  String weekday;
  List<Course> courseList;

  Weekday(String weekday, List<Course> courseList) {
    this.weekday = weekday;
    this.courseList = courseList;
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat("Hm");

    List<Widget> courseContainer = [];
    courseContainer.add(Text(weekday, style: TextStyle(fontSize: 20.0)));

    courseList.forEach((course) => courseContainer.add(ListTile(
        contentPadding: EdgeInsets.only(
            left: SizeConfig.safeBlockHorizontal * 5.0,
            right: SizeConfig.safeBlockHorizontal * 5.0),
        leading: CircleAvatar(backgroundImage: AssetImage('assets/logo.png')),
        title: Text(
          course.summary,
        ),
        subtitle: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text(
            "${formatter.format(course.start.toLocal())} - ${formatter.format(course.end.toLocal())} | ",
          ),
          Text(course.location ?? "N/A")
        ]),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          RaisedButton(
              onPressed: course.location != null
                  ? () {
                      // TODO: use localization
                      print(course.location);
                      Provider.of<MapData>(context, listen: false)
                          .changeEnd(constants.sgw);
                      Provider.of<MapData>(context, listen: false)
                          .setItinerary();
                      Provider.of<MapData>(context, listen: false)
                          .controllerDestination
                          .text = "Sir George Williams";
                      Provider.of<MapData>(context, listen: false)
                          .controllerStarting
                          .text = "Current Location";
                      Navigator.of(context).pop();
                    }
                  : null,
              elevation: 1.0,
              color: constants.greenColor,
              textColor: constants.whiteColor,
              child: Text("Directions")),
          Icon(Icons.keyboard_arrow_right)
        ]))));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: courseContainer,
    );
  }
}
