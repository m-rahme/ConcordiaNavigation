import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            color: Colors.grey,
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
