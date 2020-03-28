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
    courseContainer.add(Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(weekday, style: TextStyle(fontSize: 20.0)),
    ));

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
            "${formatter.format(course?.start?.toLocal())} - ${formatter.format(course?.end?.toLocal())} | ",
          ),
          Text((course == null ||
                  course?.location == null ||
                  course?.location == '')
              ? "N/A"
              : course.location)
        ]),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          RaisedButton(
              onPressed: (course != null && course?.location != '')
                  ? () {
                      String letter = course.location[0];
                      if (letter == "H") {
                        Provider.of<MapData>(context, listen: false)
                            .changeCampus('sgw');
                        Provider.of<MapData>(context, listen: false)
                            .changeEnd(constants.hBuilding);
                        Provider.of<MapData>(context, listen: false)
                                .controllerDestination
                                .text =
                            course.location[1] == "A"
                                ? "Hall Building, Montreal"
                                : course.location;
                      } else if (letter == "M") {
                        Provider.of<MapData>(context, listen: false)
                            .changeCampus('sgw');
                        Provider.of<MapData>(context, listen: false)
                            .controllerDestination
                            .text = course.location;
                        Provider.of<MapData>(context, listen: false)
                            .changeEnd(constants.jmsbBuilding);
                      } else if (letter == "L") {
                        Provider.of<MapData>(context, listen: false)
                            .changeCampus('loyola');
                        Provider.of<MapData>(context, listen: false)
                            .controllerDestination
                            .text = "Loyola Campus, Montreal";
                        Provider.of<MapData>(context, listen: false)
                            .changeEnd(constants.loyola);
                      } else if (letter == "J") {
                        Provider.of<MapData>(context, listen: false)
                            .changeCampus('sgw');
                        Provider.of<MapData>(context, listen: false)
                            .controllerDestination
                            .text = "John Molson Business, Montreal";
                        Provider.of<MapData>(context, listen: false)
                            .changeEnd(constants.jmsbBuilding);
                      } else if (letter == "F") {
                        Provider.of<MapData>(context, listen: false)
                            .changeCampus('sgw');
                        Provider.of<MapData>(context, listen: false)
                            .controllerDestination
                            .text = "FG Building, Montreal";
                        Provider.of<MapData>(context, listen: false)
                            .changeEnd(constants.fgBuilding);
                      }
                      Provider.of<MapData>(context, listen: false)
                          .controllerStarting
                          .text = "Current Location";
                      Provider.of<MapData>(context, listen: false)
                          .setItinerary();
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
