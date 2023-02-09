import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosatom_game/model/card.dart';
import 'package:rosatom_game/model/deck.dart';
import 'package:rosatom_game/utils/widget.dart';
import 'package:sensors/sensors.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../db/database.dart';
import 'bottom_sheet.dart';

class GameScreen extends StatefulWidget {
  static const String TAG = "GameScreen";

  final int _deckId;

  GameScreen(this._deckId);

  @override
  State<StatefulWidget> createState() => _ScreenState(_deckId);
}

class _ScreenState extends State<GameScreen> with TickerProviderStateMixin {
  final int _deckId;

  _ScreenState(this._deckId);

  Future<Deck> _deck;
  Deck _deckObj;
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _cardAnimation;
  GyroscopeEvent gyroscopeEvent;
  StreamSubscription<GyroscopeEvent> _streamSubscriptionGyro;

  @override
  void initState() {
    super.initState();
    updateDeckList();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInBack,
    ));

    _cardAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    StreamSubscription newSubscription() {
      return gyroscopeEvents.listen((event) {
        if (event.x.abs() > 2.0 && event.y.abs() > 2.0) {
          _streamSubscriptionGyro.cancel();
          setState(() {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: new Text(
                        "Вы действительно хотите начать колоду заново?"),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Да'),
                        onPressed: () {
                          updateDeckList();
                          Navigator.of(context).pop();
                          _streamSubscriptionGyro = newSubscription();
                        },
                      ),
                      TextButton(
                        child: Text('Нет'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _streamSubscriptionGyro = newSubscription();
                        },
                      )
                    ],
                  );
                });
          });
        }
      });
    }

    _streamSubscriptionGyro = newSubscription();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _streamSubscriptionGyro.cancel();
  }

  void updateDeckList() {
    _deck = DBProvider.db.getDeck(_deckId);
    _deck.then((value) => setState(() {
          _deckObj = value;
        }));
  }

  void onCardChange() {
    setState(() {
      if (_deckObj.cardList.length > 1)
        _deckObj.cardList =
            _deckObj.cardList.sublist(1, _deckObj.cardList.length);
      else
        Navigator.pushNamed(context, "/mood", arguments: _deckId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_deckObj == null)
      return Container(
        color: Colors.white,
      );
    if (_deckObj.id == DBProvider.MY_DECK_ID && _deckObj.sizeDeck == 0) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(_deckObj.color),
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
            actions: [
              _toolbar(context, () {
                setState(() {
                  updateDeckList();
                });
              })
            ],
          ),
          backgroundColor: Color(_deckObj.color),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Пока ничего не сохранено",
                style: TextStyle(
                    fontFamily: "CeraPro-Medium",
                    color: Colors.white,
                    fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Здесь будут показаны сохраненные карточки с вопросами",
                style: TextStyle(
                    fontFamily: "CeraPro-Medium",
                    color: Colors.white,
                    fontSize: 16),
                textAlign: TextAlign.center,
              )
            ],
          )));
    }
    return Stack(children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
      ),
      Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          _deckObj.gameBackground,
          fit: BoxFit.fill,
        ),
      ),
      Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.06,
          backgroundColor: Color(_deckObj.color),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          actions: [
            _toolbar(context, () {
              setState(() {
                updateDeckList();
              });
            })
          ],
        ),
        backgroundColor: Color(0x00FFFFFF),
        body: Stack(children: [
          Column(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          child: ScaleTransition(
                            scale: _scaleAnimation,
                            child: Image.asset(
                              _deckObj.gameStars,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(_deckObj.gameCardUpImage),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: image(),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          padding: const EdgeInsets.fromLTRB(26, 0, 26, 0),
                          child: _CardList(
                              _deckObj.cardList,
                              onCardChange,
                              Color(_deckObj.color),
                              _controller,
                              _cardAnimation,
                              _deckId),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(_deckObj.gameIcon),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              child: Text(
                _deckObj.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "CeraPro-Medium",
                    fontSize: 16),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          ])
        ]),
      )
    ]);
  }

  Widget image() {
    return Image.asset(_deckObj.gameCardDownImage);
  }
}

class _CardList extends StatefulWidget {
  final List<CardModel> _list;
  final Function onCardChange;
  final Color _color;
  final AnimationController _controller;
  final Animation<double> _animation;
  final _deckId;

  _CardList(this._list, this.onCardChange, this._color, this._controller,
      this._animation, this._deckId);

  @override
  State<StatefulWidget> createState() => _CardListState();
}

class _CardListState extends State<_CardList> {
  void _likeCard(CardModel card) {
    if (card.liked)
      DBProvider.db.unlikeCard(card);
    else
      DBProvider.db.likeCard(card);

    setState(() {
      card.liked = !card.liked;
      if (widget._deckId == DBProvider.MY_DECK_ID) widget.onCardChange();
    });
  }

  @override
  Widget build(BuildContext context) {
    List cards = widget._list;
    List<Widget> newList = List();

    newList.add(
      LayoutBuilder(
        builder: (context, constraints) {
          if (cards.isEmpty)
            return Center(
                child: Text(
              "В Вашей колоде пока нет карт",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'CeraPro-Medium',
                color: Colors.black,
              ),
            ));
          else
            return Draggable(
              ignoringFeedbackSemantics: false,
              feedback: Container(
                  width: constraints.maxWidth,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: _StackCard(cards[0], widget._color)),
              childWhenDragging: Container(),
              onDragStarted: () {
                if (widget._controller.isCompleted) widget._controller.reset();
                widget._controller.forward();
              },
              onDraggableCanceled: (velocity, offset) {
                widget._controller.reverse();
                if (offset.dx.abs() > 80 || offset.dy > 300) {
                  widget.onCardChange();
                }
              },
              child: Container(
                  child: _StackCard(
                cards[0],
                widget._color,
                onLike: _likeCard,
              )),
            );
        },
      ),
    );

    if (cards.length > 1) {
      newList.add(
        ScaleTransition(
            scale: widget._animation,
            child: _StackCard(cards[1], widget._color)),
      );
    }

    return Stack(children: newList.reversed.toList());
  }

  Widget invisibleFakeCard(double padding) {
    return Opacity(
      opacity: 0.0,
      child: Container(
        child: _StackCard(CardModel(0, '', 1), Colors.white),
      ),
    );
  }

  Widget visibleFakeCard(double padding) {
    return _StackCard(CardModel(0, '', 1), Colors.white);
  }
}

class _StackCard extends StatelessWidget {
  final CardModel _cardModel;
  final Color _color;
  final Function onLike;

  _StackCard(this._cardModel, this._color, {this.onLike});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(1, 0, 0, 0),
      elevation: 0,
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/card_group_top.png",
                  // centerSlice: Rect.fromLTRB(0, 0, 0, 50),
                  fit: BoxFit.fitWidth,
                  width: constraints.maxWidth,
                ),
                Expanded(
                  child: Image.asset(
                    "assets/images/card_group_btm.png",
                    fit: BoxFit.fill,
                    width: constraints.maxWidth,
                    // height: constraints.maxHeight - 100,
                  ),
                ),
              ],
            ),
            _card(context, MediaQuery.of(context).size.height * 0.5),
          ],
        ),
      ),
    );
  }

  Widget _card(context, height) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: AutoSizeText(
                  _cardModel.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'CeraPro-Medium',
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: Row(
                  children: [
                    Flexible(
                      flex: 98,
                      child: Container(
                        height: 1,
                      ),
                    ),
                    Flexible(
                      flex: 166,
                      child: Container(
                        height: 1,
                        color: _color,
                      ),
                    ),
                    Flexible(
                      flex: 98,
                      child: Container(
                        height: 1,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            if (onLike != null) onLike(_cardModel);
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
              padding: const EdgeInsets.only(top: 25, right: 40),
              child: (_cardModel.liked)
                  ? Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        "assets/images/mark.png",
                        color: _color,
                      ))
                  : Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        "assets/images/mark_empty.png",
                        color: _color,
                      ))),
        ),
      ],
    );
  }
}

Widget _toolbar(BuildContext context, Function startAgain) {
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: GestureDetector(
      child: Image.asset("assets/images/back.png", color: Colors.white),
      onTap: () {
        showBottomSheetGame(context, GameScreen.TAG, startAgain: startAgain);
      },
    ),
  );
}
