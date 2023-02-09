import 'package:flutter/material.dart';
import 'package:rosatom_game/db/database.dart';

import '../../model/deck.dart';
import '../bottom_sheet.dart';
import 'main_card.dart';

class DeckListScreen extends StatefulWidget {
  static const String TAG = "DeckListScreen";

  @override
  State<StatefulWidget> createState() => DeckListScreenState();
}

class DeckListScreenState extends State<DeckListScreen> {

  Function _onCardTap = (BuildContext context, int deckId, Deck deck) {
    if(deck.title.contains("Устойчивое развитие")){
      Navigator.pushNamed(context, '/deck_list3');
    }else if(deck.title.contains("Проектное управление")) {
      Navigator.pushNamed(context, "/deck_list2");
    }else if(deck.title.contains("Sustainable development")) {
      Navigator.pushNamed(context, '/deck_list4');
    }else{
      print("$deckId");
      Navigator.pushNamed(context, '/start_game', arguments: deckId);
    }
  };

  Future<List<Deck>> _deckList;

  @override
  void initState() {
    super.initState();
    setState(() {
      updateDeckList();
    });
  }

  void updateDeckList() {
    _deckList = DBProvider.db.getDeckShortList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                child: Image.asset("assets/images/back.png",
                    color: Color.fromRGBO(2, 94, 161, 1.0)),
                onTap: () {
                  showBottomSheetGame(context, DeckListScreen.TAG);
                },
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: FutureBuilder(
              future: _deckList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return
                    ListView(children: generateList(snapshot.data));
                } else if (snapshot.data == null || snapshot.data.lenght == 0) {
                  return Text("Нет колод!");
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }

  List<Widget> generateList(List<Deck> decks) {
    var sorted = decks.where((element) => (!element.title.contains("Проектное управление.\n") && !element.title.contains("Устойчивое развитие.\n") && !element.title.contains("Sustainable development.\n")));
    return sorted.map((deck) =>
        MainCard(
            deck,
            _onCardTap
        )
    ).toList();
  }
}
