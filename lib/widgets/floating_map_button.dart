import 'package:flutter/material.dart';

class FloatingMapButton extends StatelessWidget {
  final Color fgColor;
  final Color bgColor;
  final Icon icon;
  final double top;
  final double left;
  final VoidCallback onClick;

  const FloatingMapButton({
    this.top, this.left, this.onClick,
    this.icon: const Icon(Icons.add),
    this.bgColor: const Color(0xFFFFFFF8),
    this.fgColor: const Color(0xFF656363),
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
          onPressed: onClick,
          child: icon,
          backgroundColor: Color(0xFFFFFFF8),
          foregroundColor: Color(0xFF656363),
          elevation: 5.0,
          heroTag: null,
        ),
      ),
    );
  }
}
