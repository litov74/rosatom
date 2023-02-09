import 'package:rosatom_game/db/database.dart';

import 'card.dart';

class Deck {
  int id;
  String image;
  String subImage;
  String bottomImage;
  String title;
  String subTitle;
  String about;
  String partner;
  List<CardModel> cardList = [];
  String mediumDeckImage;
  int color;
  String gameBackground;
  String gameStars;
  String gameIcon;
  String gameCardUpImage;
  String gameCardDownImage;
  int sizeDeck = 0;

  Deck(
      {this.id,
      this.image,
      this.subImage,
      this.bottomImage,
      this.mediumDeckImage,
      this.color,
      this.gameBackground,
      this.gameStars,
      this.gameIcon,
      this.gameCardUpImage,
      this.gameCardDownImage,
      this.title,
      this.subTitle,
      this.cardList,
      this.sizeDeck,
      this.about,
      this.partner});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map[DBProvider.DECK_IMAGE] = image;
    map[DBProvider.DECK_SUB_IMAGE] = subImage;
    map[DBProvider.DECK_BOTTOM_IMAGE] = bottomImage;
    map[DBProvider.DECK_MEDIUM_IMAGE] = mediumDeckImage;
    map[DBProvider.DECK_COLOR] = color;
    map[DBProvider.DECK_BG] = gameBackground;
    map[DBProvider.CARD_STARS] = gameStars;
    map[DBProvider.CARD_ICON] = gameIcon;
    map[DBProvider.CARD_UP_IMAGE] = gameCardUpImage;
    map[DBProvider.CARD_DOWN_IMAGE] = gameCardDownImage;
    map[DBProvider.DECK_TITLE] = title;
    map[DBProvider.DECK_SUB_TITLE] = subTitle;
    map[DBProvider.DECK_ABOUT] = about;
    map[DBProvider.DECK_PARTNER] = partner;
    return map;
  }

  static Deck fromMap(Map<String, dynamic> map) {
    return Deck(
      id: map[DBProvider.ID],
      image: map[DBProvider.DECK_IMAGE],
      subImage: map[DBProvider.DECK_SUB_IMAGE],
      bottomImage: map[DBProvider.DECK_BOTTOM_IMAGE],
      mediumDeckImage: map[DBProvider.DECK_MEDIUM_IMAGE],
      color: map[DBProvider.DECK_COLOR],
      gameBackground: map[DBProvider.DECK_BG],
      gameStars: map[DBProvider.CARD_STARS],
      gameIcon: map[DBProvider.CARD_ICON],
      gameCardUpImage: map[DBProvider.CARD_UP_IMAGE],
      gameCardDownImage: map[DBProvider.CARD_DOWN_IMAGE],
      title: map[DBProvider.DECK_TITLE],
      subTitle: map[DBProvider.DECK_SUB_TITLE],
      cardList: [],
      sizeDeck: map[DBProvider.DECK_SIZE],
      about: map[DBProvider.DECK_ABOUT],
      partner: map[DBProvider.DECK_PARTNER],
    );
  }
}
