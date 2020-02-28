import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/size_config.dart';

class BuildingMarker{
//  final String initials;
//  final String title;
//  final String address;
//  final String weekday;
//  final String weekend;
  BuildContext context;

  BuildingMarker({
//    this.initials,
//    this.title,
//    this.address,
//    this.weekday,
//    this.weekend,
    this.context,
  });

  Marker GetMarker(){

    Marker bBuildingMarker = Marker(
      markerId: MarkerId('b'),
      position: LatLng(45.498121, -73.579442),
      infoWindow: InfoWindow(title: 'B Annex'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return Container(
                height: SizeConfig.safeBlockVertical * 27,
                width: SizeConfig.screenWidth,
                color: Color(0xFFFFFFF8),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 15.0, left: 15.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 65,
                                height: SizeConfig.safeBlockVertical * 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8.0),
                                  child: Text(
                                    "B Annex",
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 15.0),
                                  child: Container(
                                    width: SizeConfig.safeBlockHorizontal * 65,
                                    height: SizeConfig.safeBlockVertical * 4,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 8.0,
                                      ),
                                      child: Text(
                                        "2160 Bishop St",
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
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                              child: Container(
                                width: SizeConfig.safeBlockHorizontal * 25,
                                height: SizeConfig.safeBlockVertical * 5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {},
                                  color: Color(0xFF76C807),
                                  textColor: Colors.white,
                                  child: Text(
                                    "Directions",
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
                    Container(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.safeBlockVertical * 13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, left: 23.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 7,
                                  child: Icon(
                                    Icons.access_time,
                                    color: Color(0xFF76C807),
                                    size: 55.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 8.0),
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 75,
                                  height: SizeConfig.safeBlockVertical * 10,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Monday - Friday  07:00 - 23:00",
                                            style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20.0,
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
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
            });
      },
    );


    return bBuildingMarker;
  }

}






