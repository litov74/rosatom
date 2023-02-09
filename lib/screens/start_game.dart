import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosatom_game/screens/bottom_sheet.dart';
import 'package:rosatom_game/screens/deck_widget.dart';
import 'package:rosatom_game/utils/util.dart';
import 'package:rosatom_game/utils/widget.dart';

import '../db/database.dart';
import '../model/deck.dart';

class StartGameScreen extends StatefulWidget {
  static const String TAG = "StartGameScreen";
  final int _deckId;

  StartGameScreen(this._deckId);

  @override
  State<StatefulWidget> createState() => StartGameScreenState(_deckId);
}

class StartGameScreenState extends State<StartGameScreen> {
  final int _deckId;
  StartGameScreenState(this._deckId);

  Future<Deck> _deck;
  Future<String> token;

  @override
  void initState() {
    super.initState();
    updateDeck();
  }

  void updateDeck() {
    setState(() {
      _deck = DBProvider.db.getDeckShort(_deckId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _deck,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  toolbarHeight: MediaQuery.of(context).size.height * 0.06,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  actions: [_toolbar(context)],
                  iconTheme: IconThemeData(color: Color(0xFF025EA1)),
                ),
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.83,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.83,
                          child: Stack(
                            children: [
                              /*FutureBuilder(future: token, builder: (context, snapshot) {
                                if(snapshot.hasData) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height * 0.1,
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: SelectableText(
                                      snapshot.data,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: "CeraPro-Medium",
                                        color: Color(0xB3000000),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }
                              ),*/
                              _stackCards(_generateDeck(snapshot.data)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //verticalSpace(10),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: _cardCount(snapshot.data.sizeDeck)),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01),
                  ],
                ));
          } else
            return CircularProgressIndicator();
        });
  }

  Column _generateDeck(Deck _deck) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(top: 30.0),
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.04,
          padding: const EdgeInsets.symmetric(horizontal: 27.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(image: AssetImage("assets/images/rosatom_logo.png")),
              Image(image: AssetImage(_deck.subImage)),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.21,
          child: _imageSplash(_deck),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.3 + 8,
          padding: const EdgeInsets.only( top:8, right: 16, left: 16),
          child: _subTitleCard(_deck.subTitle),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.005,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.11,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _line(Color(_deck.color)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01 - 1,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AutoSizeText(
                  _deck.partner,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: "CeraPro-Medium",
                    color: Color(0xB3000000),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.005,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          child: Padding(
              padding: const EdgeInsets.only(left: 90, right: 90),
              child: _startBtn(context, _deckId, updateDeck)),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
      ],
    );
  }
}

Padding _stackCards(Widget deck) {
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
    padding: const EdgeInsets.only(
        bottom: 12.0 * 2, left: 12.0 * (2 - 2), right: 12.0 * (2 - 2)),
    child: StackCard(child: deck),
  ));

  return Padding(
    padding: const EdgeInsets.only(left: 12, right: 12),
    child: Stack(
      children: cards,
    ),
  );
}

Widget _imageSplash(Deck deck) {
  return Container(
    height: 170,
    child: Image(
      image: AssetImage(deck.mediumDeckImage),
      fit: BoxFit.fitHeight,
    ),
  );
}

Widget _subTitleCard(String subTitle) => AutoSizeText(
      subTitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: "CeraPro-Medium",
      ),
    );

Widget _startBtn(BuildContext context, int deckId, Function onReturn) {
  void _navigate() async {
    await Navigator.pushNamed(context, "/game", arguments: deckId);
    if (deckId == 4) onReturn();
  }

  return Container(
    height: 56,
    child: ElevatedButton(
      onPressed: () {
        _navigate();
      },
      style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80.0),
          )
        ),
          elevation: MaterialStateProperty.resolveWith<double>((Set<MaterialState> states) {
            return 10.0;
          }
        ),
        padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>((Set<MaterialState> state) {
          return EdgeInsets.all(0.0);
        })

      ),
      /*shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0),*/
      child: Ink(
        decoration: const BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(80.0)),
          gradient: const LinearGradient(
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
          alignment: Alignment.center,
          child: const AutoSizeText(
            'Начать',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontFamily: "CeraPro-Bold"),
          ),
        ),
      ),
    ),
  );
}

Widget _cardCount(int count) => AutoSizeText(
      getCardCount(count),
      style: const TextStyle(
          color: Colors.black26, fontSize: 14, fontFamily: "CeraPro-Regular"),
    );

Widget _toolbar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: GestureDetector(
      child: Image.asset("assets/images/back.png",
          color: Color.fromRGBO(2, 94, 161, 1.0)),
      onTap: () {
        showBottomSheetGame(context, StartGameScreen.TAG);
      },
    ),
  );
}

Widget _line(Color color) {
  return Container(
    height: 1,
    color: color,
    margin: const EdgeInsets.symmetric(horizontal: 27),
  );
}
