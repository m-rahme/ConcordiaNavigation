import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/services/outdoor/indoor_itinerary.dart';
import 'package:concordia_navigation/storage/app_constants.dart' as constants;
import 'package:flutter/material.dart';

class PainterService extends CustomPainter {
  int index;
  IndoorItinerary itinerary;

  PainterService(this.index, this.itinerary);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = constants.blueColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3.0;

    Path path = Path();

    ///Calculations made so match container size where the svg is built with the svg itself
    ///This way, the path will be drawn on the right X and Y coordinates
    for (IndoorLocation indoor in itinerary.path) {
      if (indoor == itinerary.path.first)
        path.moveTo(
            (constants.containerWidth * indoor.room.x) / constants.svgWidth,
            (constants.containerHeight * indoor.room.y / constants.svgHeight));

      path.lineTo(
          (constants.containerWidth * indoor.nearest.x) / constants.svgWidth,
          (constants.containerHeight * indoor.nearest.y / constants.svgHeight));

      if (indoor == itinerary.path.last)
        path.lineTo(
            (constants.containerWidth * indoor.room.x) / constants.svgWidth,
            (constants.containerHeight * indoor.room.y / constants.svgHeight));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
