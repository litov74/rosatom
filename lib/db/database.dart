import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:rosatom_game/model/card.dart';
import 'package:rosatom_game/model/deck.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {

  // region FIELDS

  static const String ID = '_id'; // card id or deck id (not used now)
  static const String DECK_TABLE = 'deck';
  static const String DECK_IMAGE = 'image';
  static const String DECK_SUB_IMAGE = 'sub_image';
  static const String DECK_BOTTOM_IMAGE = 'bottom_image';
  static const String DECK_MEDIUM_IMAGE = 'medium_image';
  static const String DECK_COLOR = 'color';
  static const String DECK_BG = 'deck_bg';
  static const String CARD_STARS = 'card_stars';
  static const String CARD_ICON = 'card_icon';
  static const String CARD_UP_IMAGE = 'card_up_image';
  static const String CARD_DOWN_IMAGE = 'card_down_image';
  static const String DECK_TITLE = 'title';
  static const String DECK_SUB_TITLE = 'sub_title';
  static const String DECK_SIZE = 'deck_size';
  static const String CARD_TABLE = 'card';
  static const String CARD_ID = 'card_id';
  static const String CARD_CONTENT = 'card_content';
  static const String FK_DECK_ID = 'deck_id';
  static const String CARD_LIKED = 'card_liked';
  static const String DECK_ABOUT = 'deck_about';
  static const String DECK_PARTNER = 'deck_parnter';

  // endregion

  static const int MY_DECK_ID = 16;

  // region INITIALIZATION

  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();

    String path = dir.path + '/rosatom.db';
    print(path);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $DECK_TABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $DECK_IMAGE TEXT, $DECK_SUB_IMAGE TEXT,$DECK_BOTTOM_IMAGE TEXT, $DECK_MEDIUM_IMAGE TEXT,$DECK_COLOR INTEGER, $DECK_BG TEXT, $CARD_STARS TEXT, $CARD_ICON TEXT, $CARD_UP_IMAGE TEXT, $CARD_DOWN_IMAGE TEXT, $DECK_TITLE TEXT, $DECK_SUB_TITLE TEXT, $DECK_ABOUT TEXT, $DECK_PARTNER TEXT)');
    await db.execute(
        'CREATE TABLE $CARD_TABLE($ID INTEGER PRIMARY KEY AUTOINCREMENT, $CARD_CONTENT TEXT, $FK_DECK_ID INTEGER, $CARD_LIKED INTEGER, FOREIGN KEY($FK_DECK_ID) REFERENCES $DECK_TABLE($ID))');
    _fillDB(db);
  }

  // endregion

  void _fillDB(Database db) async {

    // region DECK3
    await insertDeck(
        db,
        Deck(
            id: 0,
            image: 'assets/images/deck_avatar_2.png',
            subImage: 'assets/images/deck_logo_3.png',
            bottomImage: 'assets/images/deck_btm_2.png',
            mediumDeckImage: 'assets/images/deck_middle_2.png',
            color: 0xFFB1C72E,
            gameBackground: 'assets/images/bg_2.png',
            gameStars: 'assets/images/stars_2.png',
            gameIcon: 'assets/images/me_2.png',
            gameCardUpImage: 'assets/images/image_top_2.png',
            gameCardDownImage: 'assets/images/image_btm_2.png',
            title: 'Наедине с собой',
            subTitle:
            'Каждый день отвечайте себе на несколько вопросов, направляя внимание на внутренний мир и свое состояние. Обдумывайте свои действия и отношения, задавайте себе вопросы, сомневайтесь, анализируйте возникшие идеи и возможные затруднения.\nВы же не откажетесь от беседы с умным человеком?',
            cardList: [],
            sizeDeck: 0,
            about:
            'Набор карточек для откровенного разговора с самым близким человеком – самим собой',
            partner:
            'Вопросы созданы совместно с культурной платформой «Синхронизация»'))
        .then((deck) {
      insertCard(db, CardModel(0, 'Без чего бы вы не смогли прожить и дня?', deck.id));
      insertCard(db, CardModel(0, 'Хотели бы вы себе такого друга, как вы, и почему?', deck.id));
      insertCard(db, CardModel(0, 'За какие 5 вещей в вашей жизни вы можете быть благодарны?', deck.id));
      insertCard(db, CardModel(0, 'Как вы могли бы упростить свою жизнь и заниматься самым важным?', deck.id));
      insertCard(db, CardModel(0, 'Как часто вы позволяете своим страхам удержать вас от действий? Вспомните конкретный случай.', deck.id));
      insertCard(db, CardModel(0, 'Какие хорошие привычки вы бы хотели привить себе?', deck.id));
      insertCard(db, CardModel(0, 'Когда вы последний раз плакали от переживания красоты? Что вызвало слезы?', deck.id));
      insertCard(db, CardModel(0, 'Как бы могла выглядеть инструкция по жизни с вами?', deck.id));
      insertCard(db, CardModel(0, 'Какой шаг вы можете сделать сегодня для того, чтобы продвинуться навстречу задуманному?', deck.id));
      insertCard(db, CardModel(0, 'Какая ваша главная мечта?', deck.id));
      insertCard(db, CardModel(0, 'Назовите 3 качества, которые вы цените в других?', deck.id));
      insertCard(db, CardModel(0, 'Каковы ваши жизненные ценности?', deck.id));
      insertCard(db, CardModel(0, 'Когда в последний раз вы начинали активно действовать, имея в голове только смутную идею, но при этом уже сильно веря в нее?', deck.id));
      insertCard(db, CardModel(0, 'Когда вы в последний раз пробовали что-то новое?', deck.id));
      insertCard(db, CardModel(0, 'Согласились бы вы заниматься на работе только любимыми делами, но при этом меньше зарабатывать?', deck.id));
      insertCard(db, CardModel(0, 'Что вы делали в последний раз, когда потеряли счет времени?', deck.id));
      insertCard(db, CardModel(0, 'Чему в жизни вы хотели бы уделять больше внимания?', deck.id));
      insertCard(db, CardModel(0, 'Как часто вы говорите любимым людям, что вы их любите?', deck.id));
      insertCard(db, CardModel(0, 'Какое лучшее решение вы приняли в своей жизни?', deck.id));
      insertCard(db, CardModel(0, 'Когда вы в последний раз смеялись до боли в животе?', deck.id));
      insertCard(db, CardModel(0, 'Какое у вас самое счастливое воспоминание о детстве? Что делает его таким?', deck.id));
      insertCard(db, CardModel(0, 'Какой у вас девиз по жизни?', deck.id));
      insertCard(db, CardModel(0, 'Чего вы хотите достичь в этом году?', deck.id));
      insertCard(db, CardModel(0, 'Что больше помогло вашему личному росту — вызовы и испытания или приятные и уютные мгновения жизни?', deck.id));
      insertCard(db, CardModel(0, 'В какой ситуации вам проще всего посмеяться над собой, а в какой труднее?', deck.id));
      insertCard(db, CardModel(0, 'Что нового вы узнали вчера/за прошедшую неделю?', deck.id));
      insertCard(db, CardModel(0, 'Если бы вам надо было оставить только самое нужное для жизни, от каких вещей вы бы отказались?', deck.id));
      insertCard(db, CardModel(0, 'Какая из последних прочитанных книг произвела на вас сильное впечатление? Кому вы рассказали о ней?', deck.id));
      insertCard(db, CardModel(0, 'Как выглядит ваш идеальный день?', deck.id));
      insertCard(db, CardModel(0, 'Умеете ли вы прощать? Что вы не готовы простить?', deck.id));
      insertCard(db, CardModel(0, 'Что отнимает у вас энергию?', deck.id));
      insertCard(db, CardModel(0, 'Какое дело вы постоянно откладываете, а оно могло бы сделать вас счастливее?', deck.id));
      insertCard(db, CardModel(0, 'Какими жизненными принципами вы руководствуетесь?', deck.id));
      insertCard(db, CardModel(0, 'Как часто вы делитесь чем-то, не ожидая получить что-то в ответ?', deck.id));
      insertCard(db, CardModel(0, 'Кто в вашей жизни заставляет вас смеяться больше всего?', deck.id));
      insertCard(db, CardModel(0, 'Если бы вам надо было нарисовать линию своей жизни от рождения до настоящего, на каких моментах у вас были бы пики, а на каких падения?', deck.id));
      insertCard(db, CardModel(0, 'В каких ситуациях вам тяжелее всего делать выбор?', deck.id));
      insertCard(db, CardModel(0, 'Какие эмоции вы испытывали сегодня? Что было их источником?', deck.id));
      insertCard(db, CardModel(0, 'Что в этом мире вы делаете иначе, чем другие люди?', deck.id));
      insertCard(db, CardModel(0, 'Что дает вам энергию?', deck.id));
    });
    // endregion
    // region DECK2
    await insertDeck(
        db,
        Deck(
          id: 0,
          image: 'assets/images/deck_avatar_3.png',
          subImage: 'assets/images/deck_logo_2.png',
          bottomImage: 'assets/images/deck_btm_3.png',
          mediumDeckImage: 'assets/images/deck_middle_3.png',
          color: 0xFFF78E22,
          gameBackground: 'assets/images/bg_3.png',
          gameStars: 'assets/images/stars_2.png',
          gameIcon: 'assets/images/me_3.png',
          gameCardUpImage: 'assets/images/image_top_3.png',
          gameCardDownImage: 'assets/images/image_btm_3.png',
          title: 'Наедине с командой',
          subTitle:
          'Каждая карточка содержит вопрос, ответив на который, вы сможете лучше узнать себя и своих коллег. Вытаскивайте по одной карточке, зачитывайте вопрос и отвечайте. Подключайте команду к обсуждению. Отвечайте честно, как на приеме у доктора, и в результате вы получите рецепт… рецепт эффективности и успеха.',
          cardList: [],
          sizeDeck: 0,
          about: 'Набор карточек для обсуждения совместной работы с командой',
          partner:
          'Вопросы созданы совместно с Московской школой управления СКОЛКОВО',
        )).then((deck) {
      insertCard(db, CardModel(0, 'Было ли в вашей команде недопонимание, которое повлияло на вашу работу? Как можно избежать этого в будущем?', deck.id));
      insertCard(db, CardModel(0, 'В каких встречах вы хотели бы участвовать, но пока не имеете возможности?', deck.id));
      insertCard(db, CardModel(0, 'Насколько члены команды доступны, когда вам требуется помощь?', deck.id));
      insertCard(db, CardModel(0, 'Если бы вы создавали новую команду, кого бы вы хотели в нее пригласить и почему?', deck.id));
      insertCard(db, CardModel(0, 'Чего вам не хватает больше всего, когда вы работаете удаленно?', deck.id));
      insertCard(db, CardModel(0, 'Какие встречи в вашем календаре, по вашему мнению, вам не нужно посещать?', deck.id));
      insertCard(db, CardModel(0, 'Какая область работы вашей команды нуждается в улучшении больше всего?', deck.id));
      insertCard(db, CardModel(0, 'Как отличается уровень вашей мотивации, когда вы работаете в офисе и когда вы работаете удаленно?', deck.id));
      insertCard(db, CardModel(0, 'Какие новые идеи, процессы, практики вам стоит развивать, чтобы команда стала лучше?', deck.id));
      insertCard(db, CardModel(0, 'Насколько справедливо распределена нагрузка среди членов вашей команды? Что можно улучшить?', deck.id));
      insertCard(db, CardModel(0, 'Как бы вы охарактеризовали нагрузку вашей команды? Как вы можете на нее повлиять?', deck.id));
      insertCard(db, CardModel(0, 'Как бы вы оценили качество коммуникаций в вашей команде?', deck.id));
      insertCard(db, CardModel(0, 'Как вы можете улучшить еженедельные/ ежемесячные командные встречи?', deck.id));
      insertCard(db, CardModel(0, 'Как ваша команда ладит с другими командами компании?', deck.id));
      insertCard(db, CardModel(0, 'Как сделать культуру вашей компании более благоприятной для сотрудников?', deck.id));
      insertCard(db, CardModel(0, 'Как часто вы общаетесь с членами команды?', deck.id));
      insertCard(db, CardModel(0, 'Какая самая главная сила вашей команды? Кто проявляет ее лучше всего?', deck.id));
      insertCard(db, CardModel(0, 'Какие  дополнительные инструменты или ресурсы помогут вам работать эффективнее?', deck.id));
      insertCard(db, CardModel(0, 'Какие каналы связи наиболее эффективны в вашей команде?', deck.id));
      insertCard(db, CardModel(0, 'Какие качества должны быть у человека, чтобы он подходил для вашей команды?', deck.id));
      insertCard(db, CardModel(0, 'Какие события и мероприятия можно провести для укрепления сотрудничества?', deck.id));
      insertCard(db, CardModel(0, 'Какие факторы влияют на производительность команды?', deck.id));
      insertCard(db, CardModel(0, 'Каким образом вы узнаете об организационных изменениях? Что бы вы поменяли в способе информирования?', deck.id));
      insertCard(db, CardModel(0, 'Какое место в компании занимает ваша команда?', deck.id));
      insertCard(db, CardModel(0, 'Кем вы восхищаетесь в вашей команде? Что вам в них нравится?', deck.id));
      insertCard(db, CardModel(0, 'Когда вы застреваете с проблемой, как ведут себя члены команды?', deck.id));
      insertCard(db, CardModel(0, 'Насколько открытое и честное общение в вашей команде?', deck.id));
      insertCard(db, CardModel(0, 'Как бы вы сформулировали ценности вашей команды?', deck.id));
      insertCard(db, CardModel(0, 'Условия работы вашей команды более благоприятны для сотрудничества или конкуренции? Почему вы так считаете?', deck.id));
      insertCard(db, CardModel(0, 'Что вы можете сделать, чтобы способствовать большему сотрудничеству и гармонии между членами вашей команды?', deck.id));
      insertCard(db, CardModel(0, 'Как ваша команда может вдохновить вас делать вашу работу как можно лучше?', deck.id));
      insertCard(db, CardModel(0, 'Как вы думаете, какова репутация вашей команды в компании?', deck.id));
      insertCard(db, CardModel(0, 'Ваша команда мотивирует вас к развитию? А какой вклад в развитие коллег вносите вы?', deck.id));
      insertCard(db, CardModel(0, 'Чему вы научились/учитесь у своей команды?', deck.id));
      insertCard(db, CardModel(0, 'Что вас по-настоящему драйвит в работе?', deck.id));
      insertCard(db, CardModel(0, 'О какой команде вы мечтаете?', deck.id));
      insertCard(db, CardModel(0, 'В чем секрет успеха удаленных команд?', deck.id));
      insertCard(db, CardModel(0, 'В какое время вы максимально продуктивны?', deck.id));
      insertCard(db, CardModel(0, 'Вы можете рассказать, чем занимается каждый член вашей команды и какой вклад он вносит в конечный результат?', deck.id));
      insertCard(db, CardModel(0, 'Вы можете спокойно сказать любому члену команды то, что вас не устраивает, либо запросить обратную связь?', deck.id));
    }).catchError((error) {
      print(error);
    });
    // endregion
    // region DECK1
    await insertDeck(
            db,
            Deck(
                id: 0,
                image: 'assets/images/deck_avatar_1.png',
                subImage: 'assets/images/deck_logo_1.png',
                bottomImage: 'assets/images/deck_btm_1.png',
                mediumDeckImage: 'assets/images/deck_middle_1.png',
                color: 0xFF6CACE4,
                gameBackground: 'assets/images/bg_1.png',
                gameStars: 'assets/images/stars_1.png',
                gameIcon: 'assets/images/me_1.png',
                gameCardUpImage: 'assets/images/image_top_1.png',
                gameCardDownImage: 'assets/images/image_btm_1.png',
                title: 'Наедине со всеми',
                subTitle:
                    'Перед вами карточки с простыми и неожиданными вопросами о ваших отношениях с миром настоящего и будущего, его восприятии и понимании. Чем легче вопрос, тем более сложным и неоднозначным может быть ответ. Вытаскивайте по одной карточке, зачитывайте вопрос, отвечайте, дискутируйте.',
                cardList: [],
                sizeDeck: 0,
                about: 'Набор карточек для досуга \nв любой компании',
                partner:
                    'Вопросы созданы совместно с международной организацией WorldSkills Russia'))
        .then((deck) {
      insertCard(db, CardModel(0, 'Если бы вам разрешили изменить только одну вещь в мире, что бы это было?', deck.id));
      insertCard(db, CardModel(0, 'Что такое осмысленная жизнь?', deck.id));
      insertCard(db, CardModel(0, 'Какие социальные вопросы вас больше всего волнуют?', deck.id));
      insertCard(db, CardModel(0, 'Можно ли добиться правды, не сражаясь?', deck.id));
      insertCard(db, CardModel(0, 'Как взаимосвязаны понятия «счастье» и «успех»?', deck.id));
      insertCard(db, CardModel(0, 'О чем стоит беспокоиться: сделать вещи правильно или сделать правильные вещи?', deck.id));
      insertCard(db, CardModel(0, 'Кто из окружающих помогает вам проявлять себя с лучшей стороны?', deck.id));
      insertCard(db, CardModel(0, 'Что для вас идеальный жизненный баланс?', deck.id));
      insertCard(db, CardModel(0, 'Какие люди вас вдохновляют? Почему?', deck.id));
      insertCard(db, CardModel(0, 'Выберите: стресс или штиль? Почему именно так?', deck.id));
      insertCard(db, CardModel(0, 'Как преодолеть любые препятствия на пути к успеху?', deck.id));
      insertCard(db, CardModel(0, 'Вы бы хотели прославиться? Если да, то в какой области?', deck.id));
      insertCard(db, CardModel(0, 'Что для вас любимая работа?', deck.id));
      insertCard(db, CardModel(0, 'Если не сегодняшняя профессия, то какая?', deck.id));
      insertCard(db, CardModel(0, 'Что для вас истинный профессионализм?', deck.id));
      insertCard(db, CardModel(0, 'Если бы вам предложили поучаствовать в конкурсе профессионального мастерства, то какое направление вы бы выбрали?', deck.id));
      insertCard(db, CardModel(0, 'Как бы вы объяснили ребенку, почему важно любить то, чем профессионально занимаешься?', deck.id));
      insertCard(db, CardModel(0, 'Что или кто вас подтолкнул к выбору своей профессии?', deck.id));
      insertCard(db, CardModel(0, 'Как вы поступите и что вы почувствуете, если ваш профессиональный выбор не примут окружающие и близкие?', deck.id));
      insertCard(db, CardModel(0, 'Почему для людей так важна их работа?', deck.id));
      insertCard(db, CardModel(0, 'Как бы вы объснили ребенку, почему взрослым иногда важно быть серьезными?', deck.id));
      insertCard(db, CardModel(0, 'Какой фильм лучше всего отвечает на вопрос «Как устроен мир?»?', deck.id));
      insertCard(db, CardModel(0, 'Кем лучше быть: нервным гением или счастливым дурачком?', deck.id));
      insertCard(db, CardModel(0, 'От каких занятий можно отказаться, чтобы освободить время для более важного?', deck.id));
      insertCard(db, CardModel(0, 'Продолжите фразу: «Мир через 5 лет…»', deck.id));
      insertCard(db, CardModel(0, 'Какие предметы нужно добавить в образовательную программу, чтобы подготовить детей к будущему?', deck.id));
      insertCard(db, CardModel(0, 'Какие книги должен прочитать каждый?', deck.id));
      insertCard(db, CardModel(0, 'Как поменялись увлечения людей за последние 10 лет?', deck.id));
      insertCard(db, CardModel(0, 'Какие 2-4 профессии будущего могли бы быть вам интересны?', deck.id));
      insertCard(db, CardModel(0, 'Что принесет больше пользы в будущем: быть креативным или коммуникабельным? Почему?', deck.id));
      insertCard(db, CardModel(0, 'Что лучше: принять вызов на поединок с риском утратить статус/звание или довольствоваться уже имеющейся победой?', deck.id));
      insertCard(db, CardModel(0, 'Если бы вы могли отправить всему миру послание, что бы вы сказали за 30 секунд?', deck.id));
      insertCard(db, CardModel(0, 'Какие качества присущи людям, которыми восхищается мир?', deck.id));
      insertCard(db, CardModel(0, 'В чем вы делаете богаче жизнь других людей?', deck.id));
      insertCard(db, CardModel(0, 'Кого бы вы пригласили на ужин, имея возможность позвать любого человека в мире?', deck.id));
      insertCard(db, CardModel(0, 'Что большинство даже хорошо знакомых людей не знают друг о друге?', deck.id));
      insertCard(db, CardModel(0, 'Чему людям стоит учиться друг у друга?', deck.id));
      insertCard(db, CardModel(0, 'В чем секрет счастья?', deck.id));
      insertCard(db, CardModel(0, 'Если мы учимся на своих ошибках, почему мы боимся их совершать?', deck.id));
      insertCard(db, CardModel(0, 'Какие навыки важны для успешной жизни в мире будущего?', deck.id));
    });
    // endregion

    // region GROUP_PROJECT_MANAGEMENT
    await insertDeck(db, Deck(
        id: 0,
        image: 'assets/images/deck_avatar_4.jpg',
        subImage: '',
        bottomImage: 'assets/images/deck_btm_2.png',
        mediumDeckImage: 'assets/images/deck_avatar_4.jpg',
        color: 0xFFB1C72E,
        gameBackground: 'assets/images/bg_2.png',
        gameStars: 'assets/images/stars_2.png',
        gameIcon: 'assets/images/me_2.png',
        gameCardUpImage: 'assets/images/image_top_2.png',
        gameCardDownImage: 'assets/images/image_btm_2.png',
        title: 'Проектное управление',
        subTitle:
        '',
        cardList: [],
        sizeDeck: 0,
        about:
        '',
        partner:
        'Вопросы созданы совместно с культурной платформой «Синхронизация»'
    ));
    // endregion
    // region GROUP_STRAIGHT_DEVELOPMENT
    await insertDeck(db, Deck(
        id: 0,
        image: 'assets/images/deck_avatar_5.jpg',
        subImage: '',
        bottomImage: 'assets/images/deck_btm_2.png',
        mediumDeckImage: 'assets/images/deck_middle_5.jpg',
        color: 0xFFB1C72E,
        gameBackground: 'assets/images/bg_2.png',
        gameStars: 'assets/images/stars_2.png',
        gameIcon: 'assets/images/me_2.png',
        gameCardUpImage: 'assets/images/image_top_2.png',
        gameCardDownImage: 'assets/images/image_btm_2.png',
        title: 'Устойчивое развитие',
        subTitle:
        '',
        cardList: [],
        sizeDeck: 0,
        about:
        '',
        partner:
        'Вопросы созданы совместно с культурной платформой «Синхронизация»'
    ));
    // endregion
    // region GROUP_ENGLISH_STRAIGHT_DEVELOPMENT
    await insertDeck(db, Deck(
        id: 0,
        image: 'assets/images/deck_avatar_5.jpg',
        subImage: '',
        bottomImage: 'assets/images/deck_btm_2.png',
        mediumDeckImage: 'assets/images/deck_middle_5.jpg',
        color: 0xFFB1C72E,
        gameBackground: 'assets/images/bg_2.png',
        gameStars: 'assets/images/stars_2.png',
        gameIcon: 'assets/images/me_2.png',
        gameCardUpImage: 'assets/images/image_top_2.png',
        gameCardDownImage: 'assets/images/image_btm_2.png',
        title: 'Sustainable development',
        subTitle:
        'Устойчивое развитие: версия на английском языке',
        cardList: [],
        sizeDeck: 0,
        about:
        'Устойчивое развитие: версия на\nанглийском языке',
        partner:
        'Вопросы созданы совместно с культурной платформой «Синхронизация»'
    ));
    // endregion

    // region DECK5 (Project Management)
    await insertDeck(
        db,
        Deck(
            id: 0,
            image: 'assets/images/deck_avatar_4_2.jpg',
            subImage: '',
            bottomImage: 'assets/images/deck_btm_2.png',
            mediumDeckImage: 'assets/images/deck_avatar_4_2.jpg',
            color: 0xFFB1C72E,
            gameBackground: 'assets/images/bg_2.png',
            gameStars: 'assets/images/stars_2.png',
            gameIcon: 'assets/images/me_2.png',
            gameCardUpImage: 'assets/images/image_top_2.png',
            gameCardDownImage: 'assets/images/image_btm_2.png',
            title: 'Проектное управление.\nНаедине с собой',
            subTitle:
            'Кому будут полезны вопросы? \nРуководителям проектов, участникам проектных команд, а также всем, кто хочет и видит для себя возможности развиваться в проектном управлении.\n\nКаждая карточка содержит вопрос, который поможет понять и переосмыслить свою роль, используемые инструменты и подходы в текущем проекте. Отвечайте на вопросы, ищите новые смыслы в работе над проектом и создавайте пространство для личного профессионального роста!',
            cardList: [],
            sizeDeck: 0,
            about:
            '',
            partner:
            'Вопросы созданы Центром проектных компетенций Корпоративной Академии Росатома'))
        .then((deck) {
      insertCard(db, CardModel(0, 'В чем ваши сильные стороны, как руководителя/участника команды проекта?', deck.id));
      insertCard(db, CardModel(0, 'В чем ваши зоны роста, как руководителя/ участника команды проекта?', deck.id));
      insertCard(db, CardModel(0, 'Насколько вы уверены, что ваш проект нужен? Кому и зачем?', deck.id));
      insertCard(db, CardModel(0, 'Неопределенность в проектах дарит вам вдохновение или забирает жизненную энергию? Как это проявляется?', deck.id));
      insertCard(db, CardModel(0, 'Что может привести ваш проект к немедленному закрытию?', deck.id));
      insertCard(db, CardModel(0, 'Вы сами пользуетесь тем, что создаете в проекте?', deck.id));
      insertCard(db, CardModel(0, 'Что будет с вашим проектом, если вы уйдете в отпуск на три месяца?', deck.id));
      insertCard(db, CardModel(0, 'Как давно вы общались с заказчиком вашего проекта? Изменилась ли актуальность проекта для него?', deck.id));
      insertCard(db, CardModel(0, 'Что вы готовы сделать ради своей команды проекта?', deck.id));
      insertCard(db, CardModel(0, 'Если бы вы начинали свой проект заново - что бы вы сделали по-другому?', deck.id));
      insertCard(db, CardModel(0, 'Agile или Водопад? Какие практики проектного управления вам ближе и почему?', deck.id));
      insertCard(db, CardModel(0, 'У вас есть право на ошибку в проекте?', deck.id));
      insertCard(db, CardModel(0, 'Какие риски вы видите в вашем проекте? С какими вы готовы работать, а с какими нет?', deck.id));
      insertCard(db, CardModel(0, 'Кого вы последний раз благодарили в проекте? Вспомните, за что именно?', deck.id));
      insertCard(db, CardModel(0, 'Кого следует поблагодарить за успешно проделанную работу в вашем проекте?', deck.id));
      insertCard(db, CardModel(0, 'Когда вы последний раз сравнивали текущую ситуацию в проекте с базовым планом? ', deck.id));
      insertCard(db, CardModel(0, 'Насколько вам удается выполнять поставленные на старте проекта задачи? Как длительность выполнения каждой задачи влияет на результаты вашего проекта?', deck.id));
      insertCard(db, CardModel(0, 'Что для вас важнее – быть профессионалом в своей области или командным игроком?', deck.id));
    });
    // endregion
    // region DECK4 (Project Management)
    await insertDeck(
        db,
        Deck(
          id: 0,
            image: 'assets/images/deck_avatar_4_1.jpg',
            subImage: '',
            bottomImage: 'assets/images/deck_btm_3.png',
            mediumDeckImage: 'assets/images/deck_avatar_4_1.jpg',
            color: 0xFFF78E22,
            gameBackground: 'assets/images/bg_3.png',
            gameStars: 'assets/images/stars_2.png',
            gameIcon: 'assets/images/me_3.png',
            gameCardUpImage: 'assets/images/image_top_3.png',
            gameCardDownImage: 'assets/images/image_btm_3.png',
            title: 'Проектное управление.\nНаедине с командой',
            subTitle:
            'Кому будут полезны вопросы? \nРуководителям проектов, участникам проектных команд, а также всем, кто хочет и видит для себя возможности развиваться в проектном управлении.\n\nВместе с командой вы можете ответить на несколько вопросов, которые позволят вам найти новые смыслы в работе над вашим проектом и создадут пространство для слаженной работы. Задавайте вопросы, обсуждайте командой возникшие идеи, дискутируйте и находите новые решения для вашего проекта!',
            cardList: [],
            sizeDeck: 0,
            about:
            '',
            partner:
            'Вопросы созданы Центром проектных компетенций Корпоративной Академии Росатома'))
        .then((deck) {
          insertCard(db, CardModel(0, 'Что делает вашу команду особенной?', deck.id));
          insertCard(db, CardModel(0, 'Вы можете называть себя "слаженной" командой?', deck.id));
          insertCard(db, CardModel(0, 'Как давно вы показывали результаты работы заказчику проекта?', deck.id));
          insertCard(db, CardModel(0, 'Что в вашем проекте является самым "слабым звеном"? Как это улучшить?', deck.id));
          insertCard(db, CardModel(0, 'От чего вам стоит отказаться в работе над проектом и почему?', deck.id));
          insertCard(db, CardModel(0, 'Какие ритуалы есть в вашей команде?', deck.id));
          insertCard(db, CardModel(0, 'Как часто вы говорите о рисках нашего проекта?', deck.id));
          insertCard(db, CardModel(0, 'Как вы понимаете, что проект продвигается в нужном направлении?', deck.id));
          insertCard(db, CardModel(0, 'Чему вы учитесь, работая над проектом? ', deck.id));
          insertCard(db, CardModel(0, 'В чем вы черпаете силы для работы над проектом?', deck.id));
          insertCard(db, CardModel(0, 'Как вы относитесь к изменениям в проекте?', deck.id));
          insertCard(db, CardModel(0, 'Кого следует поблагодарить за успешно проделанную работу в вашем проекте?', deck.id));
          insertCard(db, CardModel(0, 'В каких ситуациях вам приходилось преодолевать сопротивление изменениям? Как это влияло на результат?', deck.id));
          insertCard(db, CardModel(0, 'Насколько вы знаете и понимаете мотивацию каждого участника нашей команды?', deck.id));
          insertCard(db, CardModel(0, 'Что важнее - закончить проект в срок или реализовать все требования заказчика?', deck.id));
          insertCard(db, CardModel(0, 'Что будет для вас стоп-сигналом о том, что проект надо сворачивать?', deck.id));
          insertCard(db, CardModel(0, 'Какие позитивные возможности скрываются за рисками вашего проекта? ', deck.id));
          insertCard(db, CardModel(0, 'Какие практики вашей работы являются наиболее продуктивными? ', deck.id));
          insertCard(db, CardModel(0, 'Кого стоит привлечь в команду для усиления вашего проекта? ', deck.id));
          insertCard(db, CardModel(0, 'Какие регулярные активности с заказчиками есть в вашем проекте? Достаточно ли их? ', deck.id));
          insertCard(db, CardModel(0, 'Какую пользу принесет ваш проект, даже если завершится прямо сейчас? ', deck.id));
          insertCard(db, CardModel(0, 'Кто является противником вашего проекта? Можно ли его привлечь на свою сторону и как? ', deck.id));
          insertCard(db, CardModel(0, 'Кто уже знает о ваших успехах? А кто еще не знает, но ему важно узнать? ', deck.id));
          insertCard(db, CardModel(0, 'Какие эффекты от вашего проекта получает заказчик? ', deck.id));
    });
    // endregion
    // region DECK6 (Project Management)
    await insertDeck(
        db,
        Deck(
            id: 0,
            image: 'assets/images/deck_avatar_4_3.jpg',
            subImage: '',
            bottomImage: 'assets/images/deck_btm_1.png',
            mediumDeckImage: 'assets/images/deck_avatar_4_3.jpg',
            color: 0xFF6CACE4,
            gameBackground: 'assets/images/bg_1.png',
            gameStars: 'assets/images/stars_1.png',
            gameIcon: 'assets/images/me_1.png',
            gameCardUpImage: 'assets/images/image_top_1.png',
            gameCardDownImage: 'assets/images/image_btm_1.png',
            title: 'Проектное управление.\nНаедине со всеми',
            subTitle:
            'Кому будут полезны вопросы? \nУчастникам проектных команд, а также всем, кто хочет и видит для себя возможности развиваться в проектном управлении.\n\nКарточки с простыми и важными вопросами позволят вам найти новые смыслы в работе над проектом, создадут пространство для личного профессионального роста и слаженной работы проектной команды. Открывайте по одной карточке, зачитывайте вопрос, подключайте всех к обсуждению, анализируйте и вдохновляйтесь!',
            cardList: [],
            sizeDeck: 0,
            about:
            '',
            partner:
            'Вопросы созданы Центром проектных компетенций Корпоративной Академии Росатома'))
        .then((deck) {
      insertCard(db, CardModel(0, 'Насколько цель вашего проекта мотивирует и зажигает людей?', deck.id));
      insertCard(db, CardModel(0, 'Вы говорите с заказчиком на "одном языке"? Как вы это понимаете?', deck.id));
      insertCard(db, CardModel(0, 'Какую и чью "боль" решает ваш проект?', deck.id));
      insertCard(db, CardModel(0, 'Насколько вы понимаете критерии успеха проекта, над которым работаете?', deck.id));
      insertCard(db, CardModel(0, 'Кто желает успеха вашему проекту? Как вы это используете?', deck.id));
      insertCard(db, CardModel(0, 'Кто желает провала вашему проекту? Можно ли это изменить?', deck.id));
      insertCard(db, CardModel(0, 'У вашего проекта есть наставник? В чем он вам помогает?', deck.id));
      insertCard(db, CardModel(0, 'Как хорошо вы знаете тех, кто будет пользоваться продуктом вашего проекта?', deck.id));
      insertCard(db, CardModel(0, 'Что самое ценное в результатах вашего проекта?', deck.id));
      insertCard(db, CardModel(0, 'Какими качествами и навыками обладает или должен обладать участник проектной команды?', deck.id));
      insertCard(db, CardModel(0, 'Какими качествами и навыками обладает или должен обладать руководитель проекта? ', deck.id));
      insertCard(db, CardModel(0, 'Стоит ли начинать проект в кризис? Ваши аргументы "за" и "против".', deck.id));
    });
    // endregion
    // region DECK4 (Straight Development)
    await insertDeck(
        db,
        Deck(
            id: 0,
            image: 'assets/images/deck_avatar_5_2.jpg',
            subImage: '',
            bottomImage: 'assets/images/deck_btm_2.png',
            mediumDeckImage: 'assets/images/deck_avatar_5_2.jpg',
            color: 0xFFB1C72E,
            gameBackground: 'assets/images/bg_2.png',
            gameStars: 'assets/images/stars_2.png',
            gameIcon: 'assets/images/me_2.png',
            gameCardUpImage: 'assets/images/image_top_2.png',
            gameCardDownImage: 'assets/images/image_btm_2.png',
            title: 'Устойчивое развитие.\nНаедине с собой',
            subTitle:
            'Кому будут полезны вопросы? \nВсем, кто знает, и кто хочет узнать больше про устойчивое развитие.\n\nНабор карточек с важными вопросами, которые вы можете задать себе, чтобы определить и сформировать приоритеты в понимании устойчивого развития. Вытаскивайте по одной карточке, обдумывайте свои чувства, действия и отношение!',
            cardList: [],
            sizeDeck: 0,
            about:
            '',
            partner:
            'Вопросы созданы Отделом исследований и программ по устойчивому развитию Корпоративной Академии Росатома'))
    .then((deck) {
      insertCard(db, CardModel(0, 'Как Вы следите за своим эмоциональным и психологическим равновесием?', deck.id));
      insertCard(db, CardModel(0, 'Насколько вы приветствуете инклюзивность на рабочем месте (люди разных возрастов и полов, с разными способностями)?', deck.id));
      insertCard(db, CardModel(0, 'Вы чувствуете, что ваша работа приносит пользу? В чем это выражается?', deck.id));
      insertCard(db, CardModel(0, 'Что вы испытываете, если не укладываетесь по задаче в сроки? Как справляетесь с эмоциями?', deck.id));
      insertCard(db, CardModel(0, 'Насколько вам комфортно работать в команде со специалистами разных возрастов? Как вы способствуете созданию комфортной среды в такой команде?', deck.id));
      insertCard(db, CardModel(0, 'Какие действия вы предпринимаете, если коллега не понимает задачу с первого раза, чтобы сохранить эмоциональное спокойствие?', deck.id));
      insertCard(db, CardModel(0, 'Как вы "перезагружаетесь" после выполнения сложных задач или переработок?', deck.id));
      insertCard(db, CardModel(0, 'Насколько вы согласны с утверждением, что делать ошибки - это нормально?', deck.id));
      insertCard(db, CardModel(0, 'Как вы благодарите коллег за проделанную работу или помощь?', deck.id));
      insertCard(db, CardModel(0, 'Как часто вы думаете о своей внутренней устойчивости и самочувствии?', deck.id));
      insertCard(db, CardModel(0, 'Вы стараетесь соблюдать баланс между работой и личной жизнью? Что помогает, а что мешает соблюдать?', deck.id));
    });
    // endregion
    // region DECK5 (Straight Development)
    await insertDeck(
        db,
        Deck(
            id: 0,
            image: 'assets/images/deck_avatar_5_1.jpg',
            subImage: '',
            bottomImage: 'assets/images/deck_btm_3.png',
            mediumDeckImage: 'assets/images/deck_avatar_5_1.jpg',
            color: 0xFFF78E22,
            gameBackground: 'assets/images/bg_3.png',
            gameStars: 'assets/images/stars_2.png',
            gameIcon: 'assets/images/me_3.png',
            gameCardUpImage: 'assets/images/image_top_2.png',
            gameCardDownImage: 'assets/images/image_btm_2.png',
            title: 'Устойчивое развитие.\nНаедине с командой',
            subTitle:
            'Кому будут полезны вопросы? \nВсем, кто знает, и кто хочет узнать все про устойчивое развитие.\n\nКаждая карточка содержит вопрос, ответив на который вы сможете лучше узнать себя и коллег, определить и сформировать приоритеты в понимании устойчивого развития для команды. Подключайте команду к обсуждению, вытаскивайте по одной карточке, зачитывайте вопрос и отвечайте!',
            cardList: [],
            sizeDeck: 0,
            about:
            '',
            partner:
            'Вопросы созданы Отделом исследований и программ по устойчивому развитию Корпоративной Академии Росатома'))
        .then((deck) {
      insertCard(db, CardModel(0, 'В каком случае вы чувствуете себя комфортно при взаимодействии со своей командой?', deck.id));
      insertCard(db, CardModel(0, 'Насколько члены вашей команды открыты к сотрудничеству друг с другом? Как это проявляется?  ', deck.id));
      insertCard(db, CardModel(0, 'Как вы понимаете, что ваша команда работает эффективно?', deck.id));
      insertCard(db, CardModel(0, 'Насколько вы интегрируете ESG-принципы (экологические, социальные и управленческие) при запуске нового проекта?', deck.id));
      insertCard(db, CardModel(0, 'Что вы понимаете под клиентоцентричным подходом? Насколько ваша команда придерживается человекоцентричного подхода? Почему это важно?', deck.id));
      insertCard(db, CardModel(0, 'Как при реализации вашей деятельности вы соблюдаете права человека внутри команды и по отношению к другим стейкхолдерам?', deck.id));
      insertCard(db, CardModel(0, 'Как в вашей команде проявляется поддержка концепции рационального водопотребления и энергопотребления?', deck.id));
      insertCard(db, CardModel(0, 'Насколько комфортно в вашей команде вы можете общаться с коллегами на нерабочие темы?', deck.id));
      insertCard(db, CardModel(0, 'В каких экологических инициативах участвует ваша команда? Почему это важно для команды?', deck.id));
      insertCard(db, CardModel(0, 'Насколько при взаимодействии с заказчиком, общественностью или иными вовлеченными сторонами в рамках вашей деятельности вы учитываете их интересы? Почему это важно?', deck.id));
      insertCard(db, CardModel(0, 'Какой продукт создает ваша команда? Насколько он может быть полезен обществу?', deck.id));
      insertCard(db, CardModel(0, 'Насколько долгосрочны цели, над которыми работает ваша команда?', deck.id));
      insertCard(db, CardModel(0, 'Насколько ваша команда понимает долгосрочные и устойчивые эффекты от той работы, которую делает?', deck.id));
      insertCard(db, CardModel(0, 'Каким образом вы оцениваете эффективность поставщиков/подрядчиков: социальные и экологические обязательства)?', deck.id));
    });
    // endregion
    // region DECK6 (Straight Development)
    await insertDeck(
        db,
        Deck(
            id: 0,
            image: 'assets/images/deck_avatar_5_3.jpg',
            subImage: '',
            bottomImage: 'assets/images/deck_btm_1.png',
            mediumDeckImage: 'assets/images/deck_avatar_5_3.jpg',
            color: 0xFF6CACE4,
            gameBackground: 'assets/images/bg_1.png',
            gameStars: 'assets/images/stars_1.png',
            gameIcon: 'assets/images/me_1.png',
            gameCardUpImage: 'assets/images/image_top_1.png',
            gameCardDownImage: 'assets/images/image_btm_1.png',
            title: 'Устойчивое развитие.\nНаедине со всеми',
            subTitle:
            'Кому будут полезны вопросы? \nВсем, кто знает, и кто хочет узнать все про устойчивое развитие.\n\nПеред вами карточки с простыми вопросами, благодаря которым вы можете обсудить в компании вопросы устойчивого развития. Открывайте по одной карточке, зачитывайте вопрос, подключайте всех к обсуждению, анализируйте и вдохновляйтесь!',
            cardList: [],
            sizeDeck: 0,
            about:
            '',
            partner:
            'Вопросы созданы Отделом исследований и программ по устойчивому развитию Корпоративной Академии Росатома'))
        .then((deck) {
      insertCard(db, CardModel(0, 'Насколько важна повестка устойчивого развития? Что вы вкладываете в это понятие?', deck.id));
      insertCard(db, CardModel(0, 'Насколько важно, чтобы компании открыто публиковали финансовые или нефинансовые отчеты для внешней аудитории?', deck.id));
      insertCard(db, CardModel(0, 'Насколько вашей компании/команде было бы полезным обучение по устойчивому развитию и ESG?', deck.id));
      insertCard(db, CardModel(0, 'В каких добровольных инициативах вы участвуете (волонтерство, высадка деревьев, субботники, социальные проекты и пр.)? Какую пользу они приносят?', deck.id));
      insertCard(db, CardModel(0, 'Какой вклад результаты вашей деятельности вносят в развитие общества?', deck.id));
      insertCard(db, CardModel(0, 'Насколько для вас важно, чтобы в организации соблюдали права человека? Какие, на ваш взгляд, приоритетные обязательства должна взять ваша компания в области прав человека?', deck.id));
      insertCard(db, CardModel(0, 'Должны ли компании брать обязательства по достижению социальных и экологических целей?  Почему это важно?', deck.id));
      insertCard(db, CardModel(0, 'Должна ли компания выбирать партнеров, исходя из их приверженности социальным и экологическим обязательствам? Как это должно регулироваться?', deck.id));
    });
    // endregion
    // region DECK7 (English Straight Development)
    await insertDeck(
        db,
        Deck(
            id: 0,
            image: 'assets/images/deck_avatar_5_2.jpg',
            subImage: '',
            bottomImage: 'assets/images/deck_btm_2.png',
            mediumDeckImage: 'assets/images/deck_avatar_5_2.jpg',
            color: 0xFFB1C72E,
            gameBackground: 'assets/images/bg_2.png',
            gameStars: 'assets/images/stars_2.png',
            gameIcon: 'assets/images/me_2.png',
            gameCardUpImage: 'assets/images/image_top_2.png',
            gameCardDownImage: 'assets/images/image_btm_2.png',
            title: 'Sustainable development.\nAlone with yourself',
            subTitle:
            'Who are these questions for? Everyone who knows what sustainable development is and wants to know more about it.\n\nA set of cards with important questions for yourself to identify and form priorities in understanding sustainable development. Taking the cards one by one, think about your feelings, actions, and attitudes.',
            cardList: [],
            sizeDeck: 0,
            about:
            '',
            partner:
            'These questions were created in cooperation with the Department of Research and Programs on Sustainable Development of the Rosatom Corporate Academy.'))
        .then((deck) {
      insertCard(db, CardModel(0, 'How do you keep your emotional and psychological balance?', deck.id));
      insertCard(db, CardModel(0, 'To what extent do you welcome inclusivity at work (people of different ages and genders, of different abilities)?', deck.id));
      insertCard(db, CardModel(0, 'Do you feel that your work is valuable? How?', deck.id));
      insertCard(db, CardModel(0, 'How do you feel if you don’t meet a deadline? How do you cope with that?', deck.id));
      insertCard(db, CardModel(0, 'How comfortable do you feel working in a multi-aged team? How do you contribute to creating a comfortable environment in such a team?', deck.id));
      insertCard(db, CardModel(0, 'What actions do you take to maintain а psychological balance if a colleague fails to grasp an assignment right away?', deck.id));
      insertCard(db, CardModel(0, 'How do you "recharge" after difficult tasks or overwork?', deck.id));
      insertCard(db, CardModel(0, 'To what extent do you agree that it is okay to make mistakes?', deck.id));
      insertCard(db, CardModel(0, 'How do you thank your colleagues for their work or help?', deck.id));
      insertCard(db, CardModel(0, 'How often do you think about your inner stability and well-being?', deck.id));
      insertCard(db, CardModel(0, 'Are you trying to maintain a work-life balance? What helps and what prevents you from doing it?', deck.id));
    });
    // endregion
    // region DECK8 (English Straight Development)
    await insertDeck(
        db,
        Deck(
            id: 0,
            image: 'assets/images/deck_avatar_5_1.jpg',
            subImage: '',
            bottomImage: 'assets/images/deck_btm_3.png',
            mediumDeckImage: 'assets/images/deck_avatar_5_1.jpg',
            color: 0xFFF78E22,
            gameBackground: 'assets/images/bg_3.png',
            gameStars: 'assets/images/stars_2.png',
            gameIcon: 'assets/images/me_3.png',
            gameCardUpImage: 'assets/images/image_top_3.png',
            gameCardDownImage: 'assets/images/image_btm_3.png',
            title: 'Sustainable development.\nAlone with the team',
            subTitle:
            'Who are these questions for? Everyone who knows what sustainable development is and wants to know more about it.\n\nEach card contains a question for you to be able to know yourself and your colleagues better, identify and form priorities in understanding sustainable development for the team. Together with your team, take the cards one by one, read the questions and answer them.',
            cardList: [],
            sizeDeck: 0,
            about:
            '',
            partner:
            'These questions were created by the Department of Research and Programs on Sustainable Development of the Rosatom Corporate Academy'))
        .then((deck) {
      insertCard(db, CardModel(0, 'When do you feel comfortable while working with your team?', deck.id));
      insertCard(db, CardModel(0, 'How open are your team members for cooperation in a team? How is it expressed?', deck.id));
      insertCard(db, CardModel(0, 'How do you understand that your team is effective?', deck.id));
      insertCard(db, CardModel(0, 'How do you incorporate ESG principles (environmental, social, and governance) when launching a new project?', deck.id));
      insertCard(db, CardModel(0, 'What do you mean by a client-centric approach? To what extent does your team adhere to the human-centered approach? Why is this important?', deck.id));
      insertCard(db, CardModel(0, 'How do you respect human rights within the team and concerning other stakeholders during your work?', deck.id));
      insertCard(db, CardModel(0, 'How do you follow the concept of efficient water and energy consumption in your team?', deck.id));
      insertCard(db, CardModel(0, 'Can you talk to your colleagues on non-work-related topics? To what extent?', deck.id));
      insertCard(db, CardModel(0, 'What environmental initiatives does your team participate in? Why is it important?', deck.id));
      insertCard(db, CardModel(0, 'How much do you respect the interests of the customer, the public, or other stakeholders in your work? Why is this important?', deck.id));
      insertCard(db, CardModel(0, 'What product does your team create? How can it benefit the society?', deck.id));
      insertCard(db, CardModel(0, 'How long-term are the goals of your team?', deck.id));
      insertCard(db, CardModel(0, 'How much does your team understand the long-term effects and sustainable effects of their work?', deck.id));
      insertCard(db, CardModel(0, 'How do you evaluate the effectiveness of your suppliers/contractors: their social and environmental obligations?', deck.id));
    });
    // endregion
    // region DECK9 (English Straight Development)
    await insertDeck(
        db,
        Deck(
            id: 0,
            image: 'assets/images/deck_avatar_5_3.jpg',
            subImage: '',
            bottomImage: 'assets/images/deck_btm_1.png',
            mediumDeckImage: 'assets/images/deck_avatar_5_3.jpg',
            color: 0xFF6CACE4,
            gameBackground: 'assets/images/bg_1.png',
            gameStars: 'assets/images/stars_1.png',
            gameIcon: 'assets/images/me_1.png',
            gameCardUpImage: 'assets/images/image_top_1.png',
            gameCardDownImage: 'assets/images/image_btm_1.png',
            title: 'Sustainable development.\nAlone with everyone',
            subTitle:
            'Who are these questions for? Everyone who knows what sustainable development is and wants to know more about it.\n\nYou have got cards with simple questions to help you discuss the issues of sustainable development within the company. Take the cards one by one, read the question out loud, involve everyone into discussion, analyze, and get inspired!',
            cardList: [],
            sizeDeck: 0,
            about:
            '',
            partner:
            'These questions were created by the Department of Research and Programs on Sustainable Development of the Rosatom Corporate Academy'))
        .then((deck) {
          /*
           */
      insertCard(db, CardModel(0, 'How important is the sustainable development agenda? What do you mean by this concept?', deck.id));
      insertCard(db, CardModel(0, 'How is it important for companies to openly publish financial or non-financial reports for the external audience?', deck.id));
      insertCard(db, CardModel(0, 'How useful would it be for your company/team to take training on ESG?', deck.id));
      insertCard(db, CardModel(0, 'What voluntary initiatives do you take part in? (volunteering, tree planting, community work, social projects, etc.)? How are they beneficial?', deck.id));
      insertCard(db, CardModel(0, 'How much do you feel your work contributes to society development?', deck.id));
      insertCard(db, CardModel(0, 'How important for you is the observance of human rights in your company? What priority obligations do you think your company should take in the field of human rights?', deck.id));
      insertCard(db, CardModel(0, 'Should companies commit themselves to achieve social and environmental goals? Why is this important?', deck.id));
      insertCard(db, CardModel(0, 'Do you think that a company should choose partners based on their commitment to the social and environmental responsibilities? How should this be regulated?', deck.id));
    });
    // endregion

    // region DECK_FAV
    await insertDeck(db, Deck(
      id: 0,
      image: 'assets/images/deck_avatar_0.png',
      subImage: 'assets/images/deck_logo_0.png',
      bottomImage: 'assets/images/deck_btm_0.png',
      mediumDeckImage: 'assets/images/deck_middle_0.png',
      color: 0xFF025EA1,
      gameBackground: 'assets/images/bg_0.png',
      gameStars: 'assets/images/stars_1.png',
      gameIcon: 'assets/images/me_0.png',
      gameCardUpImage: 'assets/images/image_top_0.png',
      gameCardDownImage: 'assets/images/image_btm_0.png',
      title: 'Мой выбор',
      subTitle:
      'Набор выбранных вами карточек, которые хочется дополнительно осмыслить или обсудить',
      cardList: [],
      sizeDeck: 0,
      about: 'Набор выбранных вами карточек, которые хочется дополнительно осмыслить или обсудить',
      partner:
      '',

    ));
    // endregion

  }

  Future<void> init() async {
    var db = await this.database;
    // db.close();
  }

  Future<List<Deck>> getDeckShortList() async {
    Database db = await this.database;
    String query =
        'SELECT d.*, (SELECT count(1) FROM $CARD_TABLE where d.$ID = $FK_DECK_ID) as $DECK_SIZE FROM $DECK_TABLE d';
    final List<Map<String, dynamic>> deckMpList =
        await db.rawQuery(query).catchError((error) {
      print(error);
    });
    final List<Deck> deckList = [];
    deckMpList.forEach((element) {
      deckList.add(Deck.fromMap(element));
    });
    return deckList;
  }

  Future<Deck> getDeckShort(int deckId) async {
    Database db = await this.database;

    String query = (deckId == MY_DECK_ID)
        ? 'SELECT d.*, (SELECT count(1) FROM card where card_liked= 1) as deck_size FROM deck d WHERE d._id= $MY_DECK_ID'
        :'SELECT d.*, (SELECT count(1) FROM $CARD_TABLE where d.$ID = $FK_DECK_ID) as $DECK_SIZE FROM $DECK_TABLE d WHERE d.$ID = $deckId';
    final List<Map<String, dynamic>> deckMpList =
        await db.rawQuery(query).catchError((error) {
      print(error);
    });
    if (deckMpList.isEmpty) return null;
    return Deck.fromMap(deckMpList[0]);
  }

  Future<Deck> getDeck(int deckId) async {
    Database db = await this.database;
    String query = (deckId == MY_DECK_ID)
        ? 'SELECT d.*, (SELECT count(1) FROM card where card_liked= 1) as deck_size FROM deck d WHERE d._id= $MY_DECK_ID'
        :'SELECT d.*, (SELECT count(1) FROM $CARD_TABLE where d.$ID = $FK_DECK_ID) as $DECK_SIZE FROM $DECK_TABLE d WHERE d.$ID = $deckId';
    final List<Map<String, dynamic>> deckMpList =
        await db.rawQuery(query).catchError((error) {
      print(error);
    });
    if (deckMpList.isEmpty) return null;
    Deck deck = Deck.fromMap(deckMpList[0]);
    deck.cardList = (deck.id != MY_DECK_ID)? await geCardList(deck.id): await getLikedList();
    return deck;
  }

  Future<List<CardModel>> geCardList(int deckID) async {
    Database db = await this.database;
    String query = 'SELECT * FROM $CARD_TABLE WHERE $FK_DECK_ID = $deckID';
    final List<Map<String, dynamic>> mapList = await db.rawQuery(query);
    final List<CardModel> cardList = [];
    mapList.forEach((element) {
      cardList.add(CardModel.fromMap(element));
    });
    return cardList;
  }

  Future<List<CardModel>> getLikedList() async {
    Database db = await this.database;
    String query = 'SELECT * FROM $CARD_TABLE WHERE $CARD_LIKED = 1';
    final List<Map<String, dynamic>> mapList = await db.rawQuery(query);
    final List<CardModel> cardList = [];
    mapList.forEach((element) {
      cardList.add(CardModel.fromMap(element));
    });
    return cardList;
  }


  Future<CardModel> likeCard(CardModel card) async{
    Database db = await this.database;
    card.liked = true;
    int id = card.id;
    String query =
        'UPDATE $CARD_TABLE SET $CARD_LIKED=1 where $ID = $id';
    await db.rawQuery(query).catchError((error) {
      print(error);
    });
    return card;
  }


  Future<CardModel> unlikeCard(CardModel card) async{
    Database db = await this.database;
    card.liked = false;
    String query =
        'UPDATE $CARD_TABLE SET $CARD_LIKED=0 where $ID = ${card.id}';
    await db.rawQuery(query).catchError((error) {
      print(error);
    });
    return card;
  }


  Future<Deck> insertDeck(Database db, Deck deck) async {
    Map<String, dynamic> map = deck.toMap();
    int id = await db.insert(DECK_TABLE, map);
    deck.id = id;
    return deck;
  }

  Future<CardModel> insertCard(Database db, CardModel card) async {
    card.id = await db.insert(CARD_TABLE, card.toMap());
    return card;
  }
}
