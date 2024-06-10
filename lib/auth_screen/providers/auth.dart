import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:statistics_maneger/providers/database.dart';

class Auth with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  Future<void> signup(Map<String, String?> userData) async {
    final connectivityResult = await InternetAddress.lookup('google.com')
        .timeout(
          const Duration(seconds: 4),
          onTimeout: () => throw Exception(
              'no internet connection or internet is very slow'),
        )
        .onError(
          (error, stackTrace) => throw Exception(
              'no internet connection or internet is very slow'),
        );

    if (!connectivityResult.isNotEmpty ||
        !connectivityResult[0].rawAddress.isNotEmpty) {
      throw Exception('no internet connection or internet is very slow');
    }

    final amount = (await _fireStore.collection('price').doc('manager').get())
        .get('amount') as int;

    await TheDatabase.saveCredintials(
        {'name': userData['name'], 'shopName': userData['shopName']});
    await TheDatabase.theDatabase.update(
      'user',
      {'paymentAmount': amount},
    );

    await _auth.createUserWithEmailAndPassword(
        email: '${userData['name']!}@gmail.com',
        password: userData['password']!);

    await _fireStore
        .collection('/users')
        .doc("${userData['name']!}${userData['shopName']!}")
        .set({
      'name': userData['name'],
      'password': userData['password'],
      'hasPaid': false,
      'timeStamp': Timestamp.now(),
    });
  }

  Future<void> login(Map<String, String?> userData) async {
    final connectivityResult = await InternetAddress.lookup('google.com')
        .timeout(
          const Duration(seconds: 4),
          onTimeout: () => throw Exception(
              'no internet connection or internet is very slow'),
        )
        .onError(
          (error, stackTrace) => throw Exception(
              'no internet connection or internet is very slow'),
        );

    if (!connectivityResult.isNotEmpty ||
        !connectivityResult[0].rawAddress.isNotEmpty) {
      throw Exception('no internet connection or internet is very slow');
    }
    try {
      final shopId = (await _fireStore
              .collection('/users')
              .where('name', isEqualTo: userData['name'])
              .get())
          .docs[0]
          .id
          .replaceFirstMapped(userData['name']!, (match) => '');

      final amount = (await _fireStore.collection('price').doc('manager').get())
          .get('amount') as int;

      await TheDatabase.theDatabase.update(
        'user',
        {'paymentAmount': amount},
      );
      await TheDatabase.saveCredintials(
          {'name': userData['name'], 'shopName': shopId});
    } catch (e) {
      throw Exception('this account doesn\'t exist');
    }
    await _auth.signInWithEmailAndPassword(
        email: '${userData['name']!}@gmail.com',
        password: userData['password']!);
  }

  Future<void> logout(bool delete) async {
    await TheDatabase.firebaseMessaging.deleteToken();

    await databaseFactory.deleteDatabase(TheDatabase.databasePath);
    await _auth.signOut();

    await SystemNavigator.pop();
  }
}
