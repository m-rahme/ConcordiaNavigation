import 'package:concordia_navigation/models/indoor/indoor_location.dart';
import 'package:concordia_navigation/services/outdoor/indoor_itinerary.dart';
import 'package:flutter/material.dart';

class PainterService extends CustomPainter {
  int index;
  IndoorItinerary itinerary;

  PainterService(this.index, this.itinerary);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3.0;

    Path path = Path();

    for (IndoorLocation indoor in itinerary.path) {
      if (indoor == itinerary.path.first)
        path.moveTo((940 * indoor.room.x) / 1000, (862 * indoor.room.y / 920));

      path.lineTo(
          (940 * indoor.nearest.x) / 1000, (862 * indoor.nearest.y / 920));

      if (indoor == itinerary.path.last)
        path.lineTo((940 * indoor.room.x) / 1000, (862 * indoor.room.y / 920));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
