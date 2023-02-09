String getCardCount(int count) {
  return formatCount(count, "карточка", "карточки", "карточек");
}

String formatCount(int count, String str1, String str2_5, String str5) {
  int nMod = count % 10;

  if (count >= 5 && count <= 20) {
    return "$count $str5";
  } else if (nMod == 1) {
    return "$count $str1";
  } else if (nMod == 2 || nMod == 3 || nMod == 4) {
    return "$count $str2_5";
  } else {
    return "$count $str5";
  }
}
