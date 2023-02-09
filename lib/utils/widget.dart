import 'package:flutter/material.dart';

Widget footer() {
  AssetImage _image = AssetImage("assets/images/splash.png");
  return Padding(
      padding: EdgeInsets.only(bottom: 0),
      child: Center(
        child: Image(image: _image),
      ));
}

SizedBox verticalSpace(double _height) => SizedBox(
      height: _height,
    );

SizedBox horizontalSpace(double _width) => SizedBox(
      width: _width,
    );

Flexible verticalFlex(int flex) => Flexible(
      flex: flex,
      child: Container(),
    );
