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
    String startLocation = "";
    String endLocation = "";
    Set<IndoorLocation> locH1 = new Set<IndoorLocation>();
    Set<IndoorLocation> locH8 = new Set<IndoorLocation>();
    Set<IndoorLocation> locH9 = new Set<IndoorLocation>();
    Set<IndoorLocation> locMB = new Set<IndoorLocation>();

    List<Node> result = IndoorData.shortest.pathTo(startLocation, endLocation);

    Path path = Path();

    for (Node node in result) {
      switch (node.name.substring(0, 2)) {
        case "H1":
          locH1.add(IndoorData.indoors[node.name]);
          break;
        case "H8":
          locH8.add(IndoorData.indoors[node.name]);
          break;
        case "H9":
          locH9.add(IndoorData.indoors[node.name]);
          break;
        case "MB":
          locMB.add(IndoorData.indoors[node.name]);
          break;
      }
    }

    switch (index) {
      case 0:
        for (IndoorLocation indoor in locH1) {
          if (indoor == locH1.first) {
            path.moveTo(
                (940 * indoor.room.x) / 1000, (862 * indoor.room.y / 920));
          }
          path.lineTo(
              (940 * indoor.nearest.x) / 1000, (862 * indoor.nearest.y / 920));
          if (indoor == locH1.last) {
            path.lineTo(
                (940 * indoor.room.x) / 1000, (862 * indoor.room.y / 920));
          }
        }
        break;
      case 1:
        for (IndoorLocation indoor in locH8) {
          if (indoor == locH8.first) {
            path.moveTo(
                (940 * indoor.room.x) / 1000, (862 * indoor.room.y / 920));
          }
          path.lineTo(
              (940 * indoor.nearest.x) / 1000, (862 * indoor.nearest.y / 920));
          if (indoor == locH8.last) {
            path.lineTo(
                (940 * indoor.room.x) / 1000, (862 * indoor.room.y / 920));
          }
        }
        break;
      case 2:
        for (IndoorLocation indoor in locH9) {
          if (indoor == locH9.first) {
            path.moveTo(
                (940 * indoor.room.x) / 1000, (862 * indoor.room.y / 920));
          }
          path.lineTo(
              (940 * indoor.nearest.x) / 1000, (862 * indoor.nearest.y / 920));
          if (indoor == locH9.last) {
            path.lineTo(
                (940 * indoor.room.x) / 1000, (862 * indoor.room.y / 920));
          }
        }
        break;
      case 3:
        for (IndoorLocation indoor in locMB) {
          if (indoor == locMB.first) {
            path.moveTo(
                (940 * indoor.room.x) / 1000, (862 * indoor.room.y / 920));
          }
          path.lineTo(
              (940 * indoor.nearest.x) / 1000, (862 * indoor.nearest.y / 920));
          if (indoor == locMB.last) {
            path.lineTo(
                (940 * indoor.room.x) / 1000, (862 * indoor.room.y / 920));
          }
        }
        break;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
