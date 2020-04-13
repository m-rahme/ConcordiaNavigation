import 'package:concordia_navigation/storage/app_constants.dart';
import 'package:flutter/material.dart';

class FloatingMapButton extends StatelessWidget {
  final Key key;
  final Color fgColor;
  final Color bgColor;
  final Icon icon;
  final double top;
  final double left;
  final VoidCallback onClick;

  const FloatingMapButton({
    this.key,
    this.top,
    this.left,
    this.onClick,
    this.icon: const Icon(Icons.add),
    this.bgColor: whiteColor,
    this.fgColor: greyColor,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: top,
          left: left,
        ),
        child: FloatingActionButton(
          key: key,
          onPressed: onClick,
          child: icon,
          backgroundColor: this.bgColor,
          foregroundColor: this.fgColor,
          elevation: 5.0,
          heroTag: null,
        ),
      ),
    );
  }
}
