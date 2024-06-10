import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:statistics_maneger/languages/texts.dart';
import 'package:statistics_maneger/auth_screen/auth_screen.dart';
import 'package:statistics_maneger/auth_screen/providers/auth.dart';
import 'package:statistics_maneger/main_screen/home_screen.dart';
import 'package:statistics_maneger/main_screen/providers/firebase_data.dart';
import 'package:statistics_maneger/settengs_screen/setteng_screen.dart';
import 'package:statistics_maneger/workers_screen/worker_screen/worker_screen.dart';
import 'package:statistics_maneger/providers/database.dart';
import 'package:statistics_maneger/main_screen/providers/work_data.dart';
import 'package:statistics_maneger/workers_screen/workers_screen.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'default_notification_channel_id', // id
  'High Importance Notifications', // title
  importance: Importance.high, playSound: true, enableVibration: true,
  showBadge: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyApHk17PB81K7uVK0lkbIqn9IGo8pBBJhs",
          appId: "1:32914581241:android:aa854feb5517cc7fd16428",
          messagingSenderId: "32914581241",
          projectId: "statistics-1ba97"));
  await TheDatabase.databaseOpenner();

  await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
      android: AndroidInitializationSettings('noti_icon')));

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await TheDatabase.firebaseMessaging
      .setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);

  await TheDatabase.firebaseMessaging.requestPermission(
      provisional: true,
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      sound: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => WorkData(),
        ),
        ChangeNotifierProxyProvider<WorkData, FirebaseData>(
          update: (context, value, previous) => FirebaseData(
            value.addType,
            value.addWorkLocally,
            value.getFromLocalDatabase,
            value.deleteAddedWork,
          ),
          create: (context) =>
              FirebaseData((e,s) {}, (a, id) {}, (f) {}, (id) {}),
        ),
      ],
      builder: (context, child) => GetMaterialApp(
        locale: Locale(TheDatabase.localCode.replaceRange(2, null, ''),
            TheDatabase.localCode.replaceRange(0, 3, '')),
        fallbackLocale: Locale(TheDatabase.localCode.replaceRange(2, null, ''),
            TheDatabase.localCode.replaceRange(0, 3, '')),
        translations: Texts(),
        title: 'Threadly Maneger',
        theme: TheDatabase.themes[0],
        darkTheme: TheDatabase.themes[1],
        themeMode: TheDatabase.themeMode,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) =>
              snapshot.hasData ? const HomeScreen() : const AuthScreen(),
        ),
        routes: {
          AuthScreen.route: (context) => const AuthScreen(),
          HomeScreen.route: (context) => const HomeScreen(),
          WorkersScreen.route: (context) => const WorkersScreen(),
          WorkerScreen.route: (context) => const WorkerScreen(),
          SettengsScreen.route: (context) => const SettengsScreen(),
        },
      ),
    );
  }
}
