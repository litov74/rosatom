import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Toolbar extends StatelessWidget {
  Function _onResetPressed;

  Toolbar(this._onResetPressed);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          padding: EdgeInsets.all(8),
          onPressed: _onResetPressed,
          icon: ImageIcon(
            AssetImage("assets/images/restart.png"),
            color: Colors.white,
          // ),
            ),
        ),
        Container(
          padding: EdgeInsets.only(left: 0, right: 20),
          child: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

        ),
      ],
    );
  }
}
