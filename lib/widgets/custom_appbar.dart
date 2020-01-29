import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[700],
            blurRadius: 5.0,
            spreadRadius: 0.0,
            offset: Offset(
              1.0,
              3.0,
              // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            color: Colors.grey[900],
            splashColor: Colors.white,
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
              FocusScope.of(context).requestFocus(new FocusNode());
            },
          ),
          Expanded(
            child: TextField(
              cursorColor: Colors.blue,
              keyboardType: TextInputType.text,
              keyboardAppearance: Brightness.light,
              textInputAction: TextInputAction.go,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  hintText: "Search"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
