import 'package:concordia_navigation/services/painters.dart';
import 'package:flutter/material.dart';
import 'package:concordia_navigation/widgets/indoor_widget.dart';

class IndoorPage extends StatelessWidget {
  final PageController controller =
      PageController(viewportFraction: 1, keepPage: true);
  final currentPageValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: controller,
            itemCount: Painters.painters.length,
            itemBuilder: (context, index) {
              return IndoorWidget(index);
            },
          ),
        ),
      ],
    );
  }
}
