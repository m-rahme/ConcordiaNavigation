import 'package:concordia_navigation/models/user_location.dart';
import 'package:concordia_navigation/providers/buildings_data.dart';
import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/models/size_config.dart';
import 'package:concordia_navigation/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
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
  UserLocation _location;

  Future setInitialCamera() async {
    UserLocation location = UserLocation.fromLocationData(
        await LocationService.getInstance().getLocationData());
    _initialCamera = CameraPosition(
      target: location.toLatLng(),
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
    );
    return location;
  }

  @override
  void initState() {
    super.initState();
    Future location = setInitialCamera();
    location.then((value) => _location = value);
    SizeConfig();
  }

  @override
  Widget build(BuildContext context) {
    if (_location != null) {
      Provider.of<MapData>(
        context,
        listen: false,
      ).changeCurrentLocation(_location.toLatLng());
    }
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
                Provider.of<MapData>(context, listen: false)
                    .animateTo(pos.latitude, pos.longitude);
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
