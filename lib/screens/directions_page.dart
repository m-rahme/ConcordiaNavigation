import 'package:concordia_navigation/models/map_data.dart';
import 'package:concordia_navigation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/models/size_config.dart';
import 'package:provider/provider.dart';

class DirectionsPage extends StatefulWidget {
  static Color _white = Color(0xFFFFFFFF);
  static Color _blue = Color(0xFF017BFF);
  static Color _swapCar;
  static Color _swapTransit;
  static Color _swapWalking;
  static Color _swapBike;

  @override
  _DirectionsPageState createState() => _DirectionsPageState();
}

class _DirectionsPageState extends State<DirectionsPage> {
  var _controllerStarting;
  var _controllerDestination;

  @override
  void initState() {
    super.initState();
    DirectionsPage._swapCar = DirectionsPage._blue;
    DirectionsPage._swapTransit = DirectionsPage._white;
    DirectionsPage._swapWalking = DirectionsPage._white;
    DirectionsPage._swapBike = DirectionsPage._white;
  }

  @override
  Widget build(BuildContext context) {
    _controllerStarting = Provider.of<MapData>(context).controllerStaring;
    _controllerDestination =
        Provider.of<MapData>(context).controllerDestination;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        drawer: CustomDrawer(),
        body: Builder(
          builder: (context) => Column(
            children: <Widget>[
              Container(
                color: Color(0xFF73C700),
                height: SizeConfig.safeBlockVertical * 24,
                width: SizeConfig.screenWidth,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.dehaze),
                            color: Colors.white,
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.directions_car),
                                color: DirectionsPage._swapCar,
                                onPressed: () {
                                  setState(() {
                                    if (DirectionsPage._swapCar ==
                                        DirectionsPage._white) {
                                      DirectionsPage._swapCar =
                                          DirectionsPage._blue;
                                      DirectionsPage._swapTransit =
                                          DirectionsPage._white;
                                      DirectionsPage._swapWalking =
                                          DirectionsPage._white;
                                      DirectionsPage._swapBike =
                                          DirectionsPage._white;
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.train),
                                color: DirectionsPage._swapTransit,
                                onPressed: () {
                                  setState(() {
                                    if (DirectionsPage._swapTransit ==
                                        DirectionsPage._white) {
                                      DirectionsPage._swapTransit =
                                          DirectionsPage._blue;
                                      DirectionsPage._swapCar =
                                          DirectionsPage._white;
                                      DirectionsPage._swapWalking =
                                          DirectionsPage._white;
                                      DirectionsPage._swapBike =
                                          DirectionsPage._white;
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.directions_walk),
                                color: DirectionsPage._swapWalking,
                                onPressed: () {
                                  setState(() {
                                    if (DirectionsPage._swapWalking ==
                                        DirectionsPage._white) {
                                      DirectionsPage._swapWalking =
                                          DirectionsPage._blue;
                                      DirectionsPage._swapCar =
                                          DirectionsPage._white;
                                      DirectionsPage._swapTransit =
                                          DirectionsPage._white;
                                      DirectionsPage._swapBike =
                                          DirectionsPage._white;
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.directions_bike),
                                color: DirectionsPage._swapBike,
                                onPressed: () {
                                  setState(() {
                                    if (DirectionsPage._swapBike ==
                                        DirectionsPage._white) {
                                      DirectionsPage._swapBike =
                                          DirectionsPage._blue;
                                      DirectionsPage._swapCar =
                                          DirectionsPage._white;
                                      DirectionsPage._swapTransit =
                                          DirectionsPage._white;
                                      DirectionsPage._swapWalking =
                                          DirectionsPage._white;
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        height: SizeConfig.safeBlockVertical * 5,
                        width: SizeConfig.safeBlockHorizontal * 75,
                        decoration: BoxDecoration(
                          color: DirectionsPage._white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[600],
                              blurRadius: 3.0,
                              spreadRadius: -1.0,
                              offset: Offset(
                                1.0,
                                3.0,
                                // Move to bottom 10 Vertically
                              ),
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.search),
                            Expanded(
                              child: TextField(
                                controller: _controllerStarting,
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.text,
                                keyboardAppearance: Brightness.light,
                                textInputAction: TextInputAction.go,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    hintText: "Choose Starting Point"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              height: 13.0,
                              child: IconButton(
                                padding: EdgeInsets.only(bottom: 0.0),
                                icon: Icon(
                                  Icons.swap_vert,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  var temp = _controllerStarting.text;
                                  _controllerStarting.text =
                                      _controllerDestination.text;
                                  _controllerDestination.text = temp;
                                },
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        height: SizeConfig.safeBlockVertical * 5,
                        width: SizeConfig.safeBlockHorizontal * 75,
                        decoration: BoxDecoration(
                          color: DirectionsPage._white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[600],
                              blurRadius: 3.0,
                              spreadRadius: -1.0,
                              offset: Offset(
                                1.0,
                                3.0,
                                // Move to bottom 10 Vertically
                              ),
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.search),
                            Expanded(
                              child: TextField(
                                controller: _controllerDestination,
                                cursorColor: Colors.blue,
                                keyboardType: TextInputType.text,
                                keyboardAppearance: Brightness.light,
                                textInputAction: TextInputAction.go,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    hintText: "Choose Destination"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.all(0.0),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return new ListTile(
                          contentPadding: EdgeInsets.only(
                              left: SizeConfig.safeBlockHorizontal * 8.0),
                          leading: Icon(Icons.directions_car),
                          title: Text("via Autoroute 76"),
                          subtitle: Text("35 Mins"),
                        );
                      })),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  color: Color(0xFF73C700),
                ),
                height: SizeConfig.safeBlockVertical * 4,
                width: SizeConfig.screenWidth,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Best Route",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "OPTIONS",
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Container(
                  height: SizeConfig.safeBlockVertical * 9,
                  width: SizeConfig.screenWidth,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.only(
                                  left: SizeConfig.safeBlockHorizontal * 8.0,
                                  right: SizeConfig.safeBlockHorizontal * 8.0),
                              leading: Icon(
                                Icons.directions_car,
                                color: Colors.black,
                              ),
                              title: Text("via Autoroute 76"),
                              subtitle: Text("35 Mins"),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 30.0),
                            height: SizeConfig.safeBlockVertical * 4,
                            width: SizeConfig.safeBlockHorizontal * 20,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "15mins",
                                  style: TextStyle(color: Color(0xFF76C807)),
                                ),
                                Text("5km"),
                              ],
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
        ),
      ),
    );
  }
}
