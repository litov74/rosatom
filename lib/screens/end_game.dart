import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosatom_game/db/database.dart';
import 'package:rosatom_game/model/deck.dart';
import 'package:rosatom_game/screens/button.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'deck_widget.dart';

class EndGameScreen extends StatefulWidget {
  final int _deckId;

  EndGameScreen(this._deckId);

  @override
  State<StatefulWidget> createState() => EndGameState(_deckId);
}

class EndGameState extends State<EndGameScreen> {
  final int _deckId;
  Future<Deck> _deck;

  EndGameState(this._deckId);

  @override
  void initState() {
    super.initState();
    setState(() {
      updateDeck();
    });
  }

  void updateDeck() {
    _deck = DBProvider.db.getDeckShort(_deckId);
  }

  Future<bool> _onWillPop() async {
    await Navigator.popUntil(context, (route) => route.isFirst);
    await Navigator.pushNamed(context, '/start_game', arguments: _deckId);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: FutureBuilder(
            future: _deck,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Container(height: MediaQuery.of(context).size.height * 0.1),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.85,
                        child: _stackCards(_info(context, snapshot.data))),
                    Container(height: MediaQuery.of(context).size.height * 0.05),
                  ],
                );
              } else
                return CircularProgressIndicator();
            }),
      ),
    );
  }
}

Widget _info(BuildContext context, Deck deck) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.02,
      ),
      //0.78
      Container(
        height: MediaQuery.of(context).size.height * 0.05,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(image: AssetImage("assets/images/rosatom_logo.png")),
              Image(image: AssetImage(deck.subImage)),
            ],
          ),
        ),
      ),
      //0.72
      Container(
          height: MediaQuery.of(context).size.height * 0.35,
          child: _imageSplash(deck)),
      //0.37
      Container(
        height: MediaQuery.of(context).size.height * 0.02,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: AutoSizeText(
            "Пройдено",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "CeraPro-Medium",
                fontSize: 16,
                color: Color(0xB3000000)),
          ),
        ),
      ),
      //0.32
      Container(
        height: MediaQuery.of(context).size.height * 0.09,
        child: Text(
          deck.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: "CeraPro-Medium",
          ),
        ),
      ),
      //0.27
      /*SizedBox(
        height: MediaQuery.of(context).size.height * 0.02,
      ),*/
      Container(
        height: MediaQuery.of(context).size.height * 0.07,
        child: Row(
          children: [
            Flexible(child: Container()),
            Flexible(
                flex: 3,
                child: Container(
                  height: 54,
                  child: RosatomButton("Начать заново", () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushNamed(context, '/start_game',
                        arguments: deck.id);
                  }),
                )),
            Flexible(child: Container())
          ],
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.001,
      ),
      //0.17
      Container(
        height: MediaQuery.of(context).size.height * 0.07,
        child: Row(
          children: [
            Flexible(child: Container()),
            Flexible(
                flex: 3,
                child: Container(
                  height: 54,
                  child: RosatomButton("Сменить колоду", () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }),
                )),
            Flexible(child: Container())
          ],
        ),
      ),
      //0.07
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.03,
      )
      // 0.02
    ],
  );
}

Widget _imageSplash(Deck deck) {
  return Image(
    image: AssetImage(deck.image),
    fit: BoxFit.fitHeight,
  );
}

Widget _stackCards(Widget deck) {
  List<Widget> cards = List.generate(
    2,
    (index) {
      return Padding(
        padding: EdgeInsets.only(
            bottom: 12.0 * index,
            left: 12.0 * (2 - index),
            right: 12.0 * (2 - index)),
        child: StackCard(),
      );
    },
  );

  cards.add(Padding(
    padding: EdgeInsets.only(
        bottom: 12.0 * 2, left: 12.0 * (2 - 2), right: 12.0 * (2 - 2)),
    child: StackCard(child: deck),
  ));

  return Padding(
    padding: EdgeInsets.only(left: 12, right: 12),
    child: Stack(
      children: cards,
    ),
  );
}
