import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as db;
import 'package:statistics_maneger/providers/theme.dart';

class TheDatabase {
  TheDatabase._();

  static late final Database theDatabase;
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static late String localCode;
  static late List<ThemeData> themes;
  static late ThemeMode themeMode;
  static String userName = '';
  static late final String databasePath;
  static late bool firstInit;

  static Future<void> databaseOpenner() async {
    final databasePath1 = '${await db.getDatabasesPath()}/statistics.db';
    databasePath = databasePath1;

    theDatabase = await db.openDatabase(
      databasePath1,
      version: 1,
      onCreate: (datab, version) async {
        await datab.execute(
            'CREATE TABLE user (id INTEGER PRIMARY KEY , value INTEGER , paymentAmount INTEGER , name STRING , shopName STRING , localCode STRING , themeMode STRING , theme STRING , firstInit INTEGER)');
        await datab.execute(
            'CREATE TABLE types (id INTEGER PRIMARY KEY , price INTEGER , name STRING )');
        await datab.execute(
            'CREATE TABLE work_data (id INTEGER PRIMARY KEY , quantity INTEGER , amountSpent INTEGER , date STRING , typeName STRING , workerId INTEGER )');
        await datab.execute(
            'CREATE TABLE work_conformation (id INTEGER PRIMARY KEY , quantity INTEGER , amountSpent INTEGER , date STRING , typeName STRING , oringinalId INTEGER , workerId INTEGER)');
        await datab.execute(
            'CREATE TABLE paidAll (id INTEGER PRIMARY KEY , amount INTEGER , date STRING , workerId INTEGER)');
        await datab.execute(
            'CREATE TABLE workers (id INTEGER PRIMARY KEY , name STRING , token STRING)');
        await datab.execute(
            'CREATE TABLE waiting_paidAll (id INTEGER PRIMARY KEY , date STRING , workerId INTEGER)');

        await datab.insert('user', {
          'value': 0,
          'name': '',
          'shopName': '',
          'localCode':
              '${Get.deviceLocale?.languageCode}_${Get.deviceLocale?.countryCode}',
          'themeMode': 'auto',
          'theme': 'blue',
          'firstInit': 0
        });
      },
    );

    final userdata = (await theDatabase.query('user'))[0];

    firstInit = userdata['fistInit'] == 0;

    localCode = userdata['localCode'] as String;

    userName = '${userdata['name']}${userdata['shopName']}';

    switch (userdata['themeMode'] as String) {
      case 'auto':
        themeMode = ThemeMode.system;
        break;
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
    }

    switch (userdata['theme'] as String) {
      case 'golden':
        themes = AppTheme.golden;
        break;
      case 'blue':
        themes = AppTheme.blue;
        break;
      case 'brown':
        themes = AppTheme.brown;
        break;
      case 'grey':
        themes = AppTheme.grey;
        break;
    }
  }

  static Future<void> updatelocal() async {
    final userdata = (await theDatabase.query('user'))[0];
    localCode = userdata['localCode'] as String;
  }

  static Future<void> updateThemeMode() async {
    final userdata = (await theDatabase.query('user'))[0];
    switch (userdata['themeMode'] as String) {
      case 'auto':
        themeMode = ThemeMode.system;
        break;
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
    }
  }

  static Future<void> updateTheme() async {
    final userdata = (await theDatabase.query('user'))[0];
    switch (userdata['theme'] as String) {
      case 'golden':
        themes = AppTheme.golden;
        break;
      case 'blue':
        themes = AppTheme.blue;
        break;
      case 'brown':
        themes = AppTheme.brown;
        break;
      case 'grey':
        themes = AppTheme.grey;
        break;
    }
  }

  static Future<void> updateFirstInit() async {
    await theDatabase.update('user', {'firstInit': 1});
  }

  static Future<int> saveCredintials(Map<String, String?> userData) async {
    final id = await theDatabase.update(
        'user', {'name': userData['name']!, 'shopName': userData['shopName']},
        where: 'id=1', conflictAlgorithm: ConflictAlgorithm.replace);
    userName = '${userData['name']}${userData['shopName']}';
    return id;
  }
}
