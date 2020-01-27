import 'package:flutter/material.dart';
import 'screens/map.dart';
import 'widgets/custom_appbar.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Concordia Navigation',
      routes: {
//          Welcome.id: (context) => Welcome(),
//          Register.id: (context) => Register(),
//          Login.id: (context) => Login(),
//          Create.id: (context) => Create(),
//          Settings.id: (context) => Settings()
      },
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
//    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // call this method here to hide soft keyboard
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: <Widget>[
            MapPage(),
            CustomAppBar(
              height: 63,
            ),
          ],
        ),
      ),
    );
  }
}
