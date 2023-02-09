import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class RosatomButton extends StatelessWidget {
  final String _text;
  final Function _onPressed;

  RosatomButton(this._text, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
/*
      elevation: 10,
*/
      onPressed: _onPressed,
      /*shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0),*/
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80.0),
          )),
          elevation: MaterialStateProperty.resolveWith<double>(
              (Set<MaterialState> states) {
            return 10.0;
          }),
          padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>((Set<MaterialState> state) {
            return EdgeInsets.all(0.0);
          })
      ),
      child: Ink(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(93, 174, 223, 1),
              Color.fromRGBO(0, 49, 116, 1),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Container(
          // min sizes for Material buttons
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          alignment: Alignment.center,
          child: AutoSizeText(
            _text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontFamily: "CeraPro-Bold"),
          ),
        ),
      ),
    );
  }
}
