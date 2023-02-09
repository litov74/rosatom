import 'package:flutter/material.dart';
import 'package:rosatom_game/model/deck.dart';

class MainCard extends StatelessWidget {
  final Deck _deck;
  final Function _onCardTap;

  MainCard(this._deck, this._onCardTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {_onCardTap(context, _deck.id, _deck)},
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 26.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        elevation: 5,
        child: Container(
          alignment: AlignmentDirectional.center,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(27.0, 8.0, 27.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(image: AssetImage("assets/images/rosatom_logo.png")),
                    Image(image: AssetImage(_deck.subImage)),
                  ],
                ),
              ),
              Image.asset(_deck.image),
              SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 27,
                  ),
                  Image(
                    image: AssetImage(_deck.bottomImage),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _deck.title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontFamily: 'CeraPro-Medium',
                          ),
                        ),
                        Text(
                          _deck.about,
                          maxLines: 3,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'CeraPro-Medium',
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
