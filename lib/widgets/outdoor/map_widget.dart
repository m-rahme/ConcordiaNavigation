import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bottomsheet_widget.dart';
import 'floating_map_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/user_location.dart';
import '../../providers/buildings_data.dart';
import '../../models/outdoor/building.dart';
import '../../providers/map_data.dart';
import '../../services/size_config.dart';
import '../../storage/app_constants.dart' as constants;

///This is the map widget that will be loaded in the home screen.
class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  bool _campus = true;
  bool _locationAvailable = true;
  bool _locationFixed = false;

  List<Marker> buildingMarkers(List<Building> buildings) {
    return buildings.where((building) => building.hasMarker()).map((building) {
      return Marker(
        markerId: MarkerId(building.name),
        anchor: const Offset(0.5, 0.5),
        position: LatLng(building.lat, building.long),
        icon: building.icon,
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (builder) {
                return BottomSheetWidget(building);
              });
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final buildingData = Provider.of<BuildingsData>(context);
    final mapData = Provider.of<MapData>(context);
    final position = Provider.of<UserLocation>(context);
    final completer = mapData.getCompleter;
    final locationService = mapData.locationService;

    _locationAvailable = (position != null);

    if (_locationAvailable == true && _locationFixed == true) {
      mapData.animateToReachable(position);
    }

    return Stack(
      children: <Widget>[
        GoogleMap(
            mapToolbarEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            compassEnabled: false,
            tiltGesturesEnabled: true,
            buildingsEnabled: false,
            mapType: MapType.normal,
            polygons: buildingData.allPolygons.toSet(),
            markers: buildingMarkers(buildingData.allBuildings).toSet(),
            indoorViewEnabled: false,
            trafficEnabled: false,
            initialCameraPosition: mapData.getFixedLocationCamera(),
            polylines: mapData.itinerary?.polylines?.toSet(),
            onMapCreated: (controller) async {
              completer.complete(controller);
            }),
        FloatingMapButton(
          top: (Provider.of<MapData>(context, listen: false)
                          .controllerStarting !=
                      null ||
                  Provider.of<MapData>(context, listen: false)
                          .controllerEnding !=
                      null)
              ? SizeConfig.blockSizeVertical * 44
              : SizeConfig.blockSizeVertical * 67,
          left: SizeConfig.safeBlockHorizontal * 83,
          icon: Icon(Icons.swap_calls),
          onClick: () {
            _locationFixed = false;
            if (_campus) {
              mapData.animateToLatLng(constants.sgw);
              _campus = false;
            } else if (_campus == false) {
              mapData.animateToLatLng(constants.loyola);
              _campus = true;
            }
          },
        ),
        FloatingMapButton(
          top: (Provider.of<MapData>(context, listen: false)
                          .controllerStarting !=
                      null ||
                  Provider.of<MapData>(context, listen: false)
                          .controllerEnding !=
                      null)
              ? SizeConfig.blockSizeVertical * 53.5
              : SizeConfig.blockSizeVertical * 76,
          left: SizeConfig.safeBlockHorizontal * 83,
          icon: gpsIcon(),
          onClick: () {
            locationService.withPermission(() {
              if (_locationAvailable == true) {
                mapData.animateToReachable(position);
                if (_locationFixed == true) {
                  _locationFixed = false;
                } else if (_locationFixed == false) {
                  _locationFixed = true;
                }
              }
            });
          },
        ),
      ],
    );
  }

  /// Dynamically produce the appropriate location icon
  Icon gpsIcon() {
    if (_locationAvailable == false) {
      return Icon(Icons.gps_off, color: constants.greyColor);
    }
    if (_locationFixed == true) {
      return Icon(Icons.gps_fixed, color: constants.blueColor);
    }
    return Icon(Icons.gps_fixed);
  }
}
