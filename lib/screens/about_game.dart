import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosatom_game/screens/button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'main_screen/deck_list.dart';

class AboutGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
      ),
      Image.asset(
        "assets/images/bg_1.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: _firstScreen(context),
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: MediaQuery.of(context).size.height * 0.05,
          title: AutoSizeText(
            "О приложении",
            style: TextStyle(
              fontFamily: "CeraPro-Medium",
            ),
          ),
          backgroundColor: Color(0xFF6CACE4),
          elevation: 0,
        ),
      ),
    ]);
  }

  Widget _firstScreen(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Image.asset("assets/images/training_stars_1.png")),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      child: Image.asset("assets/images/image_top_1.png", ),),
                  Container(
                      child: Image.asset("assets/images/image_btm_1.png",)),
                ],
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height:MediaQuery.of(context).size.height * 0.4,
                  padding: EdgeInsets.symmetric(
                    horizontal: 26,
                  ),
                  child: AutoSizeText(
                    "«Точка роста» - это досуг со смыслом для любой компании: от одного человека и до бесконечности. В приложении собраны тематические наборы карточек с вопросами к себе, коллегам, друзьям или близким. Мечтайте, сомневайтесь, вдохновляйтесь, узнавайте друг друга и просто получайте удовольствие!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'CeraPro-Medium',
                        fontSize: 18,
                        color: Color(0xB3000000)),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 28.0),
                  child: Text(
                    "Версия 2.0.3",
                    style: TextStyle(
                        fontFamily: 'CeraPro-Medium',
                        fontSize: 17,
                        color: Color(0xB3000000)),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
