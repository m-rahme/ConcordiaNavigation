import 'dart:convert';

import 'package:concordia_navigation/services/size_config.dart';
import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/services/localization.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

//Concordia Shuttle Schedule Screen
class ShuttleSchedule extends StatefulWidget {
  @override
  _ShuttleScheduleState createState() => _ShuttleScheduleState();
}

class _ShuttleScheduleState extends State<ShuttleSchedule> {
  // bool variable to know whenever the user presses the top buttons to highlight the bus schedule hours depending on the destination
  bool isSelectedSGWToLoy = false;
  bool isSelectedLoyToSGW = false;

  dynamic getSchedule() async {
    return json
        .decode(await rootBundle.loadString('assets/shuttleSchedule.json'));
  }

  // Builds the table cell to display the departure of the shuttle bus from SGW to Loyola
  Container buildTableCellSGWtoLoy(String cellDisplay) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: AnimatedDefaultTextStyle(
          style: isSelectedSGWToLoy
              ? GoogleFonts.raleway(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )
              : GoogleFonts.raleway(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
          duration: const Duration(milliseconds: 200),
          child: Text(
            cellDisplay,
          ),
        ),
      ),
    );
  }

  // Builds the table cell to display the departure of the shuttle bus from Loyola to SGW
  Container buildTableCellLoyToSGW(String cellDisplay) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Center(
        child: AnimatedDefaultTextStyle(
          style: isSelectedLoyToSGW
              ? GoogleFonts.raleway(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )
              : GoogleFonts.raleway(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
          duration: const Duration(milliseconds: 200),
          child: Text(
            cellDisplay,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSchedule(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<TableRow> rows = [];

            // note: if schedules between monday, tuesday, wednesday or thursday
            // change, this will only show that of monday
            // given they are currently the same

            // iterate through all days
            for (int k = 0; k < snapshot.data['sgw']['1'].length; k++) {
              // build the row containing the 4 times
              TableRow row = TableRow(children: [
                buildTableCellSGWtoLoy(snapshot.data['sgw']['1'][k]),
                buildTableCellSGWtoLoy(snapshot.data['sgw']['5'].length > k
                    ? snapshot.data['sgw']['5'][k] // friday
                    : '--:--'),
                buildTableCellLoyToSGW(snapshot.data['loyola']['1'][k]),
                buildTableCellLoyToSGW(snapshot.data['loyola']['5'].length > k
                    ? snapshot.data['loyola']['5'][k] // friday
                    : '--:--'),
              ]);
              rows.add(row);
            }

            return Scaffold(
              appBar: AppBar(
                title: Text(
                  ConcordiaLocalizations.of(context).shuttle,
                ),
                backgroundColor: greenColor,
              ),
              body: Center(
                child: Column(
                  children: <Widget>[
                    // Shuttle bus destinations
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: Table(
                        border: TableBorder(
                          top: BorderSide.none,
                          bottom:
                              BorderSide(width: 3.0, color: Colors.lightGreen),
                        ),
                        children: [
                          TableRow(children: [
                            buildTitleTableCellSGWToLoy('SGW to Loyola'),
                            buildTitleTableCellLoyToSGW('Loyola to SGW'),
                          ]),
                        ],
                      ),
                    ),

                    // Days of the week of shuttle bus schedule
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: Table(
                        border: TableBorder(
                          bottom:
                              BorderSide(width: 3.0, color: Colors.lightGreen),
                        ),
                        children: [
                          TableRow(children: [
                            buildTableCellSGWtoLoy('Mon-Thu'),
                            buildTableCellSGWtoLoy('Friday'),
                            buildTableCellLoyToSGW('Mon-Thu'),
                            buildTableCellLoyToSGW('Friday'),
                          ]),
                        ],
                      ),
                    ),

                    // Shuttle bus departure schedule
                    // check if sgw
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                        child: SingleChildScrollView(
                          child: Table(
                            border: TableBorder(
                              verticalInside: BorderSide(
                                  width: 1.0, color: Colors.grey[200]),
                            ),
                            children: rows,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  // Builds the button to highlight the shuttle bus schedule departure hours from SGW to Loyola
  Container buildTitleTableCellSGWToLoy(String cellDisplay) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
      child: Center(
        child: ButtonTheme(
          height: SizeConfig.safeBlockVertical * 6,
          minWidth: SizeConfig.safeBlockHorizontal * 30,
          child: RaisedButton(
            color: greenColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0)),
            onPressed: () {
              setState(
                () {
                  if (!isSelectedSGWToLoy)
                    isSelectedSGWToLoy = !isSelectedSGWToLoy;
                  if (isSelectedLoyToSGW)
                    isSelectedLoyToSGW = !isSelectedLoyToSGW;
                },
              );
            },
            child: Text(
              cellDisplay,
              style: GoogleFonts.raleway(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Builds the button to highlight the shuttle bus schedule departure hours from Loyola to SGW
  Container buildTitleTableCellLoyToSGW(String cellDisplay) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
      child: Center(
        child: ButtonTheme(
          height: SizeConfig.safeBlockVertical * 6,
          minWidth: SizeConfig.safeBlockHorizontal * 30,
          child: RaisedButton(
            color: greenColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0)),
            onPressed: () {
              setState(
                () {
                  if (!isSelectedLoyToSGW)
                    isSelectedLoyToSGW = !isSelectedLoyToSGW;
                  if (isSelectedSGWToLoy)
                    isSelectedSGWToLoy = !isSelectedSGWToLoy;
                },
              );
            },
            child: Text(
              cellDisplay,
              style: GoogleFonts.raleway(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
