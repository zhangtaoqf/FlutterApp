import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qsbk_flutter/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: SplashPage());
  }
}

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration(milliseconds: 500), () {
//      Navigator.of(context).pushReplacementNamed('/HomePage');
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (BuildContext context)=>new HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new Image.asset(
        "images/splash.jpg",
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
