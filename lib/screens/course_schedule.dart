import 'package:concordia_navigation/models/course.dart';
import 'package:concordia_navigation/services/calendar_service.dart';
import 'package:concordia_navigation/services/size_config.dart';
import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/localization.dart';
import 'package:google_fonts/google_fonts.dart';

/// User Schedule Screen
/// This should have no business logic, only handling data generated by service classes and models.
class CourseSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            CalendarService.getSchedule().then((value) => value.byWeekday()),
        initialData: 1,
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            // Uncompleted State
            case ConnectionState.none:
              return new Text('Error occurred');
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              // Completed with error
              if (snapshot.hasError)
                return Container(
                  child: Text("Error Occured"),
                );
          }
          List<Widget> weekdayContainer = [];
          for (int i = 0; i < 5; i++) {
            // iterate through weekdays
            String weekday; // TODO: use localization
            if (i == 0) {
              weekday = "Monday";
            } else if (i == 1) {
              weekday = "Tuesday";
            } else if (i == 2) {
              weekday = "Wednesday";
            } else if (i == 3) {
              weekday = "Thursday";
            } else {
              weekday = "Friday";
            }

            if (!snapshot.data[i].isEmpty) {
              print(i);
              print(snapshot.data[i]);
              ListView elemCourses = ListView.builder(
                padding:
                    EdgeInsets.only(right: SizeConfig.safeBlockHorizontal * 0),
                itemCount: snapshot
                    .data[i]?.length, // for that weekday, get its courses
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: offWhiteColor,
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: lightGreyColor),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(
                          left: SizeConfig.safeBlockHorizontal * 5.0,
                          right: SizeConfig.safeBlockHorizontal * 5.0),
                      leading: Icon(Icons.subdirectory_arrow_right),
                      title: Text(
                        snapshot.data[i][index]
                            .summary, // print the course's summary
                        style: GoogleFonts.raleway(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                          color: blackColor,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.data[i][index]
                            .description, // print the course's summary
                        style: GoogleFonts.raleway(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: blackColor,
                        ),
                      ),
                    ),
                  );
                },
              );
              weekdayContainer
                  .add(Row(children: <Widget>[Text(weekday), elemCourses]));
            }
          }

          print(weekdayContainer);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                ConcordiaLocalizations.of(context).schedule,
              ),
              backgroundColor: greenColor,
            ),
            body: Column(
              children: weekdayContainer,
            ),
          );
        });
  }
}
