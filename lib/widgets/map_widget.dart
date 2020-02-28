import 'package:concordia_navigation/models/user_location.dart';
import 'package:concordia_navigation/providers/buildings_data.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/models/size_config.dart';
import 'package:concordia_navigation/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
//*****UNCOMMENT BELLOW FOR DARK MAP*****
//import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:concordia_navigation/models/itinerary.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 50;
const double CAMERA_BEARING = 30;
const LatLng SGW = LatLng(45.495944, -73.578075);
const LatLng LOYOLA = LatLng(45.4582, -73.6405);
bool _campus = true;

//*****UNCOMMENT BELLOW FOR DARK MAP*****
//String _mapStyle;

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  CameraPosition _initialCamera;
  List<Polyline> allPolylines = [];
  PolylinePoints points = new PolylinePoints();
  List<PointLatLng> result = [];

  Future<void> setInitialCamera() async {
    var location = await LocationService().getLocation();
    _initialCamera = CameraPosition(
      target: location.toLatLng(),
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
    );
  }


//  void getDirectionData() async {
//    allPolylines = [];
//    var direction = await Navigation().getMapDirections();
//    setState(() {
//      var pointsFromJson = json.decode(direction);
//      for (int i = 0; i < 4; i++) {
//        dynamic directions = pointsFromJson["routes"][0]["legs"][0]["steps"][i]
//            ["polyline"]["points"];
//        List<PointLatLng> result2 = points.decodePolyline(directions);
//        result = new List.from(result)..addAll(result2);
//      }
//      List<LatLng> po = [];
//      result.forEach((f) {
//        po.add(LatLng(f.latitude, f.longitude));
//      });
//
//      Polyline route = new Polyline(
//        polylineId: PolylineId("route"),
//        geodesic: true,
//        points: po,
//        width: 5,
//        color: Colors.blue,
//      );
//
//      allPolylines.add(route);
//    });
//  }

  @override
  void initState() {
    super.initState();
    setInitialCamera();
    SizeConfig();
    //*****UNCOMMENT BELLOW FOR DARK MAP*****
    //*****MIGHT IMPLEMENT AUTOMATIC DARK MODE*****
//    rootBundle.loadString('assets/map_style.txt').then((string) {
//      _mapStyle = string;
//    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final _completer = Provider.of<MapData>(context).getCompleter;
    final _buildings = Provider.of<BuildingsData>(context);
    final pos = Provider.of<UserLocation>(context);

    while (_initialCamera == null) {
      return Center(child: Text("Loading Map"));
    }

    return Stack(
      children: <Widget>[
        GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            compassEnabled: false,
            tiltGesturesEnabled: true,
            buildingsEnabled: false,
            mapType: MapType.normal,
            polygons: _buildings.polygons,
            polylines: Set.from(allPolylines),
            indoorViewEnabled: false,
            trafficEnabled: false,
            initialCameraPosition: _initialCamera,
            onMapCreated: (controller) async {
              _completer.complete(controller);
//          controller.setMapStyle(_mapStyle);
            }),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.safeBlockVertical * 66,
              left: SizeConfig.safeBlockHorizontal * 83,
            ),
            child: FloatingActionButton(
              onPressed: () {
                Itinerary(SGW, LOYOLA, "driving");
                _campus
                    ? () {
                        Provider.of<MapData>(context, listen: false)
                            .animateTo(SGW.latitude, SGW.longitude);
                        _campus = false;
                      }()
                    : () {
                        Provider.of<MapData>(context, listen: false)
                            .animateTo(LOYOLA.latitude, LOYOLA.longitude);
                        _campus = true;
                      }();
              },
              child: Icon(Icons.swap_calls),
              backgroundColor: Color(0xFFFFFFF8),
              foregroundColor: Color(0xFF656363),
              elevation: 5.0,
              heroTag: null,
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.safeBlockVertical * 75,
              left: SizeConfig.safeBlockHorizontal * 83,
            ),
            child: FloatingActionButton(
              onPressed: () {
                Provider.of<MapData>(context, listen: false).animateTo(
                    pos.latitude, pos.longitude);
              },
              child: Icon(Icons.gps_fixed),
              backgroundColor: Color(0xFFFFFFF8),
              foregroundColor: Color(0xFF656363),
              elevation: 5.0,
              heroTag: null,
            ),
          ),
        ),
      ],
    );
  }
}
