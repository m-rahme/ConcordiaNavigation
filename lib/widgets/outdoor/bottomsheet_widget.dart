import 'package:concordia_navigation/models/outdoor/building.dart';
import 'package:concordia_navigation/services/localization.dart';
import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:concordia_navigation/services/size_config.dart';

class BottomSheetWidget extends StatelessWidget {
  final Building building;
  BottomSheetWidget(this.building);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.safeBlockVertical * 30,
      width: SizeConfig.screenWidth * 100,
      color: whiteColor,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                    child: Container(
                      width: SizeConfig.safeBlockHorizontal * 63,
                      height: SizeConfig.safeBlockVertical * 2.5,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 0.0,
                          left: 0.0,
                        ),
                        child: Text(
                          building.address,
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: Container(
                      width: SizeConfig.safeBlockHorizontal * 30,
                      height: SizeConfig.safeBlockVertical * 5,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/indoor');
                        },
                        color: appColor,
                        textColor: whiteColor,
                        child: Text(
                          ConcordiaLocalizations.of(context).indoor,
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 15.0),
                    child: Container(
                      width: SizeConfig.safeBlockHorizontal * 90,
                      height: SizeConfig.safeBlockVertical * 7,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0, left: 0.0),
                        child: Text(
                          building.name,
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.safeBlockVertical * 13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 23.0),
                      child: Container(
                        width: SizeConfig.safeBlockHorizontal * 15,
                        height: SizeConfig.safeBlockVertical * 7,
                        child: Icon(
                          Icons.access_time,
                          color: appColor,
                          size: 55.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: SizeConfig.safeBlockHorizontal * 75,
                      height: SizeConfig.safeBlockVertical * 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "Monday - Friday  07:00 - 23:00",
                                style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Saturday - Sunday  08:00 - 21:00",
                                style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
