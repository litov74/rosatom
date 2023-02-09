import 'package:rosatom_game/db/database.dart';

class CardModel {
  int id;
  String text;
  int deckId;
  bool liked;

  CardModel([this.id = 0, this.text, this.deckId, this.liked = false]);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map[DBProvider.CARD_CONTENT] = text;
    map[DBProvider.FK_DECK_ID] = deckId;
    map[DBProvider.CARD_LIKED] = liked?1:0;
    return map;
  }

  static CardModel fromMap(Map<String, dynamic> map) {
    return CardModel(map[DBProvider.ID], map[DBProvider.CARD_CONTENT], map[DBProvider.FK_DECK_ID], map[DBProvider.CARD_LIKED] == 1 );
  }
}
