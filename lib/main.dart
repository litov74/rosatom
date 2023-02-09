import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rosatom_game/screens/about_game.dart';
import 'package:rosatom_game/screens/digest.dart';
import 'package:rosatom_game/screens/main_screen/deck_list.dart';
import 'package:rosatom_game/screens/end_game.dart';
import 'package:rosatom_game/screens/game.dart';
import 'package:rosatom_game/screens/main_screen/deck_list2.dart';
import 'package:rosatom_game/screens/main_screen/deck_list3.dart';
import 'package:rosatom_game/screens/main_screen/deck_list4.dart';
import 'package:rosatom_game/screens/mood_check.dart';
import 'package:rosatom_game/screens/rules.dart';
import 'package:rosatom_game/screens/splash.dart';
import 'package:rosatom_game/screens/start_game.dart';
import 'package:rosatom_game/screens/training.dart';
import 'package:rosatom_game/screens/web_screen.dart';

// region NOTIFICATIONS
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
// endregion

// region CONFIGURATION
int id = 0;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String> selectNotificationStream =
    StreamController<String>.broadcast();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

const String portName = 'notification_send_port';

class ReceivedNotification {
  ReceivedNotification({
    this.id,
    this.title,
    this.body,
    this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

String selectedNotificationPayload;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

// endregion



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await flutterLocalNotificationsPlugin.cancelAll();
  await _configureLocalTimeZone();

  final NotificationAppLaunchDetails notificationAppLaunchDetails = !kIsWeb &&
      Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final List<DarwinNotificationCategory> darwinNotificationCategories =
  <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];

  final DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification:
        (int id, String title, String body, String payload) async {
      didReceiveLocalNotificationStream.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
    notificationCategories: darwinNotificationCategories,
  );
  final LinuxInitializationSettings initializationSettingsLinux =
  LinuxInitializationSettings(
    defaultActionName: 'Open notification',
    defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin,
    linux: initializationSettingsLinux,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationStream.add(notificationResponse.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == navigationActionId) {
            selectNotificationStream.add(notificationResponse.payload);
          }
          break;
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

  runApp(MyApp());
}

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

class MyApp extends StatefulWidget {

  @override
  _MyApp createState() => _MyApp();

}

class _MyApp extends State<MyApp> {

  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    testPush();
  }

  Future<void> testPush() async {
    await _isAndroidPermissionGranted().whenComplete(() => {
      print('_isAndroidPermissionGranted')
    });
    await _requestPermissions().whenComplete(() => {
      print('_requestPermissions')
    });
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    await _scheduleNewYear().whenComplete(() => {
      print('_scheduleNewYear')
    });
    await _scheduleFebruary().whenComplete(() => {
      print('_scheduleFebruary')
    });
    await _scheduleMarch().whenComplete(() => {
      print('_scheduleMarch')
    });
    await _scheduleMay().whenComplete(() => {
      print('_scheduleMay')
    });
    final out = await getCurrentNotifications();
    print(out);
    //await _repeatNotification();
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled() ??
          false;

      setState(() {
        _notificationsEnabled = granted;
      });
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      final bool granted = await androidImplementation?.requestPermission();
      setState(() {
        _notificationsEnabled = granted ?? false;
      });
    }
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        MyApp(),
                  ),
                );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String payload) async {
      await Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => MyApp(),
      ));
    });
  }

  Future<void> _repeatNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'repeating channel id', 'repeating channel name',
        channelDescription: 'repeating description');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        id++,
        'repeating title',
        'repeating body',
        RepeatInterval.everyMinute,
        notificationDetails,
        androidAllowWhileIdle: true);
    print("notification");
  }

  int notificationId = Random().nextInt(1000000);

  Future<void> _scheduleNewYear() async {

    await flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse("${notificationId}0"),
        'С праздником!',
        'С Новым Годом!',
        _nextInstanceOfNewYear(),
        const NotificationDetails(
          android: AndroidNotificationDetails('канал с поздравлениями',
              'канал с поздравлениями',
              channelDescription: 'канал с поздравлениями'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }

  Future<void> _scheduleFebruary() async {


    await flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse("${notificationId}1"),
        'С праздником!',
        'С 23 Февраля!',
        _nextInstanceOfTwentyThreeFebruary(),
        const NotificationDetails(
          android: AndroidNotificationDetails('канал с поздравлениями',
              'канал с поздравлениями',
              channelDescription: 'канал с поздравлениями'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }

  Future<void> _scheduleMarch() async {

    await flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse("${notificationId}2"),
        'С праздником!',
        'С 8 Марта!',
        _nextInstanceOfEightMarch(),
        const NotificationDetails(
          android: AndroidNotificationDetails('канал с поздравлениями',
              'канал с поздравлениями',
              channelDescription: 'канал с поздравлениями'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }

  Future<void> _scheduleMay() async {

    await flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse("${notificationId}3"),
        'С праздником!',
        'С 9 Мая!',
        _nextInstanceOfNineMay(),
        const NotificationDetails(
          android: AndroidNotificationDetails('канал с поздравлениями',
              'канал с поздравлениями',
              channelDescription: 'канал с поздравлениями'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }

  tz.TZDateTime _nextInstanceOfNewYear() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, 1, 1, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = tz.TZDateTime(tz.local, now.year + 1, DateTime.january, 1, 10);
    }
    return scheduledDate;
  }

  Future<List<ActiveNotification>> getCurrentNotifications() async {
    final List<ActiveNotification> out = await flutterLocalNotificationsPlugin.getActiveNotifications();

    return out;
  }


  tz.TZDateTime _nextInstanceOfNineMay() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, DateTime.may, 9, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = tz.TZDateTime(tz.local, now.year + 1, DateTime.may, 9, 10);
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfEightMarch() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, DateTime.march, 8, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = tz.TZDateTime(tz.local, now.year + 1, DateTime.march, 8, 10);
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfTwentyThreeFebruary() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, DateTime.february, 23, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = tz.TZDateTime(tz.local, now.year + 1, DateTime.february, 23, 10);
    }
    return scheduledDate;
  }

  @override
  void dispose() {
    didReceiveLocalNotificationStream.close();
    selectNotificationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var disableAnim = Duration(seconds: 0);

    return MaterialApp(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/splash":
            return MaterialPageRoute(builder: (context) => SplashScreen());
            break;
          case "/training":
            return MaterialPageRoute(builder: (context) => TrainingScreen());
            break;
          case "/mood":
            int deckId = settings.arguments;
            return MaterialPageRoute(builder: (context) => MoodScreen(deckId));
            break;
          case "/deck_list":
            return MaterialPageRoute(builder: (context) => DeckListScreen());
            break;
          case "/deck_list2": // для тестовых колод.
            return MaterialPageRoute(builder: (context) => DeckListScreen2());
            break;
          case "/deck_list3": // для тестовых колод.
            return MaterialPageRoute(builder: (context) => DeckListScreen3());
            break;
          case "/deck_list4":
            return MaterialPageRoute(builder: (context) => DeckListScreen4());
            break;
          case "/start_game":
            int deckId = settings.arguments;
            return MaterialPageRoute(
                builder: (context) => StartGameScreen(deckId));
            break;
          case "/game":
            int deckId = settings.arguments;
            return MaterialPageRoute(builder: (context) => GameScreen(deckId));
            break;
          case "/endGame":
            int deckId = settings.arguments;
            return MaterialPageRoute(builder: (context) => EndGameScreen(deckId));
            break;
          case "/training":
            return MaterialPageRoute(builder: (context) => TrainingScreen());
            break;
          case "/rules":
            return MaterialPageRoute(builder: (context) => RulesScreen());
            break;
          case "/aboutApp":
            return MaterialPageRoute(builder: (context) => AboutGameScreen());
            break;
          case "/aboutAcademy":
            return MaterialPageRoute(builder: (context) => WebScreen());
            break;
          case "/digest":
            return MaterialPageRoute(builder: (context) => DigestWebScreen());
            break;
        }
        return MaterialPageRoute(builder: (context) => SplashScreen());
      },
      home: SplashScreen(),
    );
  }
}
