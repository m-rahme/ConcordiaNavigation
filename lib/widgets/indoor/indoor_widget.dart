import 'package:concordia_navigation/services/painter_service.dart';
import 'package:concordia_navigation/services/painters.dart';
import 'package:flutter/material.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;

class IndoorWidget extends StatelessWidget {
  final int index;
  IndoorWidget(this.index);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => Zoom(
        initZoom: 0.0,
        zoomSensibility: 2.3,
        scrollWeight: 10.0,
        centerOnScale: true,
        backgroundColor: constants.whiteColor,
        canvasColor: constants.whiteColor,
        doubleTapZoom: false,
        enableScroll: true,
        opacityScrollBars: 0,
        width: 940,
        height: 862,
        child: Container(
          child: Stack(
            children: <Widget>[
              Painters.painters[index],
             CustomPaint(
               painter: PainterService(),
             ),
            ],
          ),
        ),
      ),
    );
  }
}
