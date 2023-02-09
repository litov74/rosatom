import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            "Правила игры",
            style: TextStyle(color: Colors.black, fontFamily: "CeraPro-Medium"),
          ),
          iconTheme: IconThemeData(color: Color(0xFF025EA1)),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              boldText(
                "«Точка роста» - это формат досуга для любой компании: от одного человека и до бесконечности.",
              ),
              formatedText("\n"),
              textWithPoint("На каждой карточке один вопрос"),
              textWithPoint(
                  "Карточки перелистываются, когда вы смахиваете их в сторону"),
              textWithPoint(
                  "Ваша задача - честно и развернуто отвечать на вопросы"),
              textWithPoint(
                  "Если вам не нравится или не понятен вопрос - перейдите к следующей карточке"),
              textWithPoint(
                  "О правилах и последовательности ответов договоритесь в группе игроков заранее."),
              formatedText("\n"),
              boldText("Варианты правил:"),
              textWithPoint(
                  "отвечайте на разные вопросы по очереди по часовой стрелке;"),
              textWithPoint(
                  "ответивший зачитывает следующий вопрос и выбирает, кто на него ответит;"),
              textWithPoint("отвечайте на один и тот же вопрос по очереди."),
              formatedText("Вариантов правил много, придумывайте свои!"),
              formatedText("\n"),
              boldText('Набор "Мой выбор"'),
              formatedText(
                  "Формируйте свой набор из карточек с вопросами, которые хотите более детально обдумать или обсудить с окружением. Для этого установите «флажок» на понравившейся карточке."),
              formatedText("\n"),
              boldText("Важно:"),
              textWithPoint(
                  "Это не соревнование, и вы не зарабатываете баллы;"),
              textWithPoint("Здесь нет правильного или неправильного ответа;"),
              textWithPoint(
                  "Главный критерий - честность перед самим собой и теми, с кем вы играете."),
            ],
          ),
        )));
  }

  Widget textWithPoint(String text, {bool whitePoint = false}) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      formatedText("•", whitePoint: whitePoint),
      SizedBox(
        width: 8,
      ),
      Expanded(child: formatedText(text)),
    ]);
  }

  Widget textWithDash(String text, {bool whitePoint = false}) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      formatedText("-", whitePoint: whitePoint),
      SizedBox(
        width: 8,
      ),
      Expanded(child: formatedText(text)),
    ]);
  }

  Widget textWithPointChild(Widget child) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      formatedText("•"),
      SizedBox(
        width: 8,
      ),
      Expanded(child: child),
    ]);
  }

  Widget boldText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, fontFamily: "CeraPro-Bold"),
    );
  }

  Widget formatedText(String text, {bool whitePoint = false}) {
    return Text(
      text,
      style: TextStyle(
          color: whitePoint ? Colors.white : Colors.black,
          fontSize: 16,
          fontFamily: "CeraPro-Regular"),
    );
  }
}
