import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosatom_game/screens/button.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TrainingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _firstScreen(context),
    );
  }

  Widget _firstScreen(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/bg_2.png",
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.45,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/training_stars_1.png")),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/image_top_2.png"),
                    Image.asset("assets/images/image_btm_2.png"),
                  ],
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.55,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 26,
                    ),
                    child: AutoSizeText(
                      "«Точка роста» - это досуг со смыслом для любой компании: от одного человека и до бесконечности. В приложении собраны тематические наборы карточек с вопросами к себе, коллегам, друзьям или близким. Мечтайте, сомневайтесь, вдохновляйтесь, узнавайте друг друга и просто получайте удовольствие!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'CeraPro-Medium',
                          fontSize: 17,
                          color: Color(0xB3000000)),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 87,
                        child: Container(),
                      ),
                      Flexible(
                          flex: 240,
                          child: Container(
                            height: 54,
                            child: RosatomButton(
                                "Начать", () => _nextScreen(context)),
                          )),
                      Flexible(
                        flex: 87,
                        child: Container(),
                      ),
                    ],
                  ),
                ),
                Container(height: MediaQuery.of(context).size.height * 0.02,)
              ],
            ),
          ),
        )
      ],
    );
  }

  void _nextScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/mood", arguments: null);
  }
}
