import 'package:flutter/material.dart';
import 'package:rosatom_game/screens/game.dart';
import 'package:rosatom_game/screens/main_screen/deck_list.dart';
import 'package:auto_size_text/auto_size_text.dart';

void showBottomSheetGame(context, String screen, {Function startAgain}) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        List<Widget> items = List();

        if (screen != DeckListScreen.TAG)
          items.add(item(context, "Игра", () {
            Navigator.pushNamed(context, "/deck_list");
          }));

        if (screen == GameScreen.TAG)
          items.add(item(context, "Начать заново", startAgain));

        items.add(item(context, "Правила игры", () {
          Navigator.pushNamed(context, "/rules");
        }));
        items.add(item(context, "О приложении", () {
          Navigator.pushNamed(context, "/aboutApp");
        }));
        items.add(item(
          context,
          "Об Академии",
          () {
            Navigator.pushNamed(context, "/aboutAcademy");
          },
          color: Color(0xFF025EA1),
        ));

        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Center(child: Image.asset("assets/images/rectangle.png")),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.56,
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  children: items,
                ),
              )
            ],
          ),
        );
      });
}

Widget item(context, String name, Function onClick, {Color color}) {
  if (color == null) color = Colors.black;
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
      onClick();
    },
    child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.06,
      color: Colors.white,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.055,
            padding: EdgeInsets.all(10),
            child: AutoSizeText(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color, fontSize: 18, fontFamily: 'CeraPro-Medium'),
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Color(0x33000000),
          )
        ],
      ),
    ),
  );
}

Widget itemWithArrow(context, String name, Function onClick) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
      onClick();
    },
    child: Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.055,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.045,
                  child: AutoSizeText(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'CeraPro-Medium'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Color(0x33000000),
          )
        ],
      ),
    ),
  );
}
