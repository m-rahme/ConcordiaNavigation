import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBar({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 107,
          color: Color(0xBF73C700),
          alignment: Alignment.center,
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            width: 320,
            height: 35,
            margin: EdgeInsets.only(top: 40.0),
            child: TextField(
              style: new TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              keyboardAppearance: Brightness.light,
              decoration: new InputDecoration(
                fillColor: Colors.black,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 3.0),
                prefixIcon: new Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
