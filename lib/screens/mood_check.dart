import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoodScreen extends StatelessWidget {

  int _deckId;
  MoodScreen(this._deckId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                _nextScreen(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset("assets/images/close.png"),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Какое у Вас настроение?",
                    style: TextStyle(
                        fontFamily: 'CeraPro-Medium',
                        fontSize: 24,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Подумайте, что влияет на ваше ресурсное состояние и как этим управлять",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'CeraPro-Medium',
                          fontSize: 16,
                          color: Color(0xB3000000)),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () {
                              _nextScreen(context);
                            },
                            child: Image.asset("assets/images/mood_sad.png")),
                        GestureDetector(
                            onTap: () {
                              _nextScreen(context);
                            },
                            child:
                                Image.asset("assets/images/mood_confused.png")),
                        GestureDetector(
                            onTap: () {
                              _nextScreen(context);
                            },
                            child: Image.asset("assets/images/mood_happy.png")),
                        GestureDetector(
                            onTap: () {
                              _nextScreen(context);
                            },
                            child:
                                Image.asset("assets/images/mood_happy_1.png")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void _nextScreen(BuildContext context) {
    if(_deckId == null)
    Navigator.pushReplacementNamed(context, "/deck_list");
    else Navigator.pushNamed(context, "/endGame", arguments: _deckId);
  }
}
