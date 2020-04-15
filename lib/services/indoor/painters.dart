import '../../models/slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// List of the canvas of the floors
final slideList = [
  Slide(svgFile: 'assets/indoor_svg/Hall-1.svg'),
  Slide(svgFile: 'assets/indoor_svg/Hall-8.svg'),
  Slide(svgFile: 'assets/indoor_svg/Hall-9.svg'),
  Slide(svgFile: 'assets/indoor_svg/MB-1.svg')
];


/// Class to draw on the indoor map
class Painters {
  static List<Widget> painters = <Widget>[];

  Painters() {
    loadPainters();
  }

  void loadPainters() {
    for (Slide slide in slideList) {
      painters.add(
        SvgPicture.asset(slide.svgFile),
      );
    }
  }
}