import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosatom_game/screens/training.dart';
import '../db/database.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    DBProvider.db.init().then((value) {
      _runTimer(context);
    });

    AssetImage _image = AssetImage("assets/images/splash.png");
    return Container(
      padding: EdgeInsets.all(28),
      color: Colors.white,
      child: Center(
        child: Image(
          image: _image,
        ),
      ),
    );
  }

  void _runTimer(BuildContext context) {
    Timer(Duration(seconds: 3), () => _nextScreen(context));
  }

  void _nextScreen(BuildContext context) async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => TrainingScreen()));
  }

}
