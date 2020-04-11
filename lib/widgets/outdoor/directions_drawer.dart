import 'package:concordia_navigation/providers/map_data.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:concordia_navigation/services/size_config.dart';
import 'package:concordia_navigation/widgets/directions_list_widget.dart';
import 'package:concordia_navigation/widgets/search_bars.dart';
import 'package:concordia_navigation/widgets/shuttle_widget.dart';
import 'package:concordia_navigation/widgets/transportation_mode_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DirectionsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<MapData>(context).panelVisible
        ? SlidingUpPanel(
            controller:
                Provider.of<MapData>(context, listen: false).panelController,
            maxHeight: SizeConfig.safeBlockVertical * 85,
            defaultPanelState: PanelState.OPEN,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            panel: Consumer<MapData>(
              builder: (context, mapData, child) => Container(
                decoration: BoxDecoration(
                  color: constants.appColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    TransportationModeWidget(),
                    SearchBars(), // top row for transportation mode selection
                    DirectionsList(), // list of directions
                    ShuttleWidget(),
                  ],
                ),
              ),
            ))
        : Container();
  }
}
