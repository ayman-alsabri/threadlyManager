import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:statistics_maneger/main_screen/providers/work_data.dart';
import 'package:statistics_maneger/providers/database.dart';
// import 'package:statistics_maneger/providers/work_data.dart';
// import 'package:usage_track/providers/database.dart';
// import 'package:usage_track/providers/work_data.dart';

class FirebaseData with ChangeNotifier {
  // final List<PaidALL?> _paidAllList;
  // final List<DayWork?> _unsupmittedList;
  final void Function(ItemType, bool) _addTypeLocally;
  // final void Function(int id) _deleteWork;
  final void Function(bool notify) _getFromLocaldatabase;
  final void Function(int id) _deleteAddWork;
  final void Function(DayWork, int workerId) _addWorkLocally;
  // final Future<void> Function({
  //   required int amountSpent,
  //   required int quantity,
  //   required String typeName,
  //   required int id,
  //   required DateTime date,
  //   required bool hasBeenSubmitted,
  // }) _addWork;
  FirebaseData(
    this._addTypeLocally,
    this._addWorkLocally,
    this._getFromLocaldatabase,
    // this._paidAllList,
    // this._unsupmittedList,
    // this._addWork,
    // this._deleteWork,
    this._deleteAddWork,
  );

  final Database _theDatabase = TheDatabase.theDatabase;
  final _fireStore = FirebaseFirestore.instance;
  final _functions = FirebaseFunctions.instance;
  bool getHasPaid = false;
  String? _token ;

  Future<void> getAndSetData() async {
    final connectivityResult =
        await InternetAddress.lookup('google.com').timeout(
      const Duration(seconds: 4),
      onTimeout: () => throw Exception('no internet'),
    );

    if (!connectivityResult.isNotEmpty ||
        !connectivityResult[0].rawAddress.isNotEmpty) {
      throw Exception('no internet');
    }

    final Map<String, dynamic> map = (await _theDatabase.query('user'))[0];

    final lastIdOrNot2 = (await _theDatabase.query('types',
        columns: ['id'], orderBy: 'id DESC'));

    final id = (lastIdOrNot2.isEmpty ? 0 : lastIdOrNot2[0]['id'] as int);

    try {
      var data = await _fireStore
          .collection('/users')
          .doc('${map['name']}${map['shopName']}')
          .collection('/types')
          .where('id', isGreaterThan: id)
          .get(const GetOptions(source: Source.server))
          .then((value) {
        return value.docs;
      });

      for (var element in data) {
        final map = element.data();
        // if (_itemTypes.isNotEmpty && map['id'] == _itemTypes.last!.id) {
        //   continue;
        // }
        await _theDatabase.insert(
            'types',
            {
              'price': map['price'],
              'name': element.id,
              'id': map['id'],
            },
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    } catch (e) {
      rethrow;
    }
    try {
      final connectivityResult =
          await InternetAddress.lookup('google.com').timeout(
        const Duration(seconds: 4),
        onTimeout: () => throw Exception('no internet'),
      );

      if (!connectivityResult.isNotEmpty ||
          !connectivityResult[0].rawAddress.isNotEmpty) {
        throw Exception('no internet');
      }

      final numberOfWorkers = (await _fireStore
                  .collection('/users')
                  .doc('${map['name']}${map['shopName']}')
                  .collection('/workers')
                  .count()
                  .get())
              .count ??
          0;
      for (int a = 1; a <= numberOfWorkers; a++) {
        final availableWork = await _theDatabase.query('work_data',
            where: 'workerId=?', whereArgs: [a], orderBy: 'date DESC');
        final availablePayments = await _theDatabase
            .query('paidAll', where: 'workerId=?', whereArgs: [a]);

        final payment = (await _fireStore
                .collection('/users')
                .doc('${map['name']}${map['shopName']}')
                .collection('/workers')
                .doc(a.toString())
                .collection('/paidAll')
                .where('id', isGreaterThan: availablePayments.length)
                .get())
            .docs;
        for (var element in payment) {
          await _theDatabase.insert('paidAll',
              {'amount': element['amount'], 'date': element.id, 'workerId': a});
        }

        final updatedPayment = await _theDatabase.query('paidAll',
            where: 'workerId=?', whereArgs: [a], orderBy: 'date DESC');
        final work = (await _fireStore
                .collection('/users')
                .doc('${map['name']}${map['shopName']}')
                .collection('/workers')
                .doc(a.toString())
                .collection('/work')
                .where('timeStamp',
                    isGreaterThan: availableWork.isEmpty
                        ? updatedPayment.isEmpty
                            ? Timestamp.fromDate(DateTime(1999))
                            : Timestamp.fromDate(DateTime.parse(
                                updatedPayment[0]['date'] as String))
                        : Timestamp.fromDate(DateTime.parse(
                            (availableWork[0]['date']) as String)))
                .get())
            .docs;

        for (var element in work) {
          if ((element['timeStamp'] as Timestamp).toDate().isAfter(
              updatedPayment.isEmpty
                  ? DateTime(1999)
                  : DateTime.parse(updatedPayment[0]['date'] as String))) {
            await _theDatabase.insert('work_data', {
              'quantity': element['quantity'],
              'amountSpent': element['amountSpent'],
              'date': element.id,
              'typeName': element['typeName'],
              'workerId': a
            });
          }
        }

        final demo = (await _fireStore
            .collection('/users')
            .doc('${map['name']}${map['shopName']}')
            .collection('/workers')
            .doc(a.toString())
            .get());
        final workerName = (demo.get('name') as String).replaceAll('_', ' ');

        final workerToken = demo.get('token') as String;

        _theDatabase.insert(
            'workers', {'id': a, 'name': workerName, 'token': workerToken},
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> hasPaid() async {
    bool payment = false;

    try {
      final list = (await _theDatabase.query('user'))[0];
      payment = list['value'] == 1;
    } catch (e) {
      rethrow;
    }
    try {
      final connectivityResult =
          await InternetAddress.lookup('google.com').timeout(
        const Duration(seconds: 4),
        onTimeout: () => throw Exception('no internet'),
      );

      if (!connectivityResult.isNotEmpty ||
          !connectivityResult[0].rawAddress.isNotEmpty) {
        throw Exception('no internet');
      }
      final Map<String, dynamic> map = (await _theDatabase.query('user'))[0];

      _token = await TheDatabase.firebaseMessaging.getToken();
      await _fireStore
          .collection('/users')
          .doc("${map['name']!}${map['shopName']!}")
          .update({'token': _token});

      final data = await _fireStore
          .collection('/users')
          .doc("${map['name']!}${map['shopName']!}")
          .get(const GetOptions(source: Source.server))
          .then((value) {
        return value;
      });
      payment = data.get('hasPaid') as bool;

      await _theDatabase.update('user', {'value': payment ? 1 : 0},
          where: 'id=1', conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      // print(e.toString());
      rethrow;
    } finally {
      getHasPaid = payment;
    }
    // notifyListeners();
  }

  Future<void> addType(String typeName, int price, bool edit) async {
    final connectivityResult =
        await InternetAddress.lookup('google.com').timeout(
      const Duration(seconds: 4),
      onTimeout: () => throw Exception('no internet'),
    );

    if (!connectivityResult.isNotEmpty ||
        !connectivityResult[0].rawAddress.isNotEmpty) {
      throw Exception('no internet');
    }

    final Map<String, dynamic> map = (await _theDatabase.query('user'))[0];

//gets last id
    final lastIdOrNot2 = (await _theDatabase.query('types',
        columns: ['id'], orderBy: 'id DESC'));

    final id = (lastIdOrNot2.isEmpty ? 0 : lastIdOrNot2[0]['id'] as int) + 1;
    final collection = _fireStore
        .collection('/users')
        .doc("${map['name']!}${map['shopName']!}")
        .collection('/types')
        .doc(typeName);
    if (edit) {
      await collection.update({'price': price});
    } else {
      await collection.set({'id': id, 'price': price});
    }

    if (edit) {
      await _theDatabase.update(
        'types',
        {'price': price},
        where: 'name=?',
        whereArgs: [typeName],
      );
      
    } else {
      await _theDatabase.insert(
        'types',
        {'name': typeName, 'price': price},
      );
    }
    final nameList = TheDatabase.userName.codeUnits;
    String name = '';
    for (var element in nameList) {
      name += element.toString();
    }

    _functions.httpsCallable('sendTypeMessage').call({
      'shopId': name,
      'data': {
        'name': typeName,
        'price': price.toString(),
        'id': edit ? '0' : id.toString(),
        'edit': edit ? '1' : '0'
      },
      'messageTitle':
          edit ? '$typeName تم تعديل سعر القطعة' : 'تمت اضافة نوع جديد',
      'messageBody':
          edit ? 'السعر الجديد $price' : ':النوع $typeName,سعر القطعة: $price'
    });
    _addTypeLocally(ItemType(id: id, name: typeName, price: price), edit);
  }

  Future<void> addPayment(int userId, int amount) async {
    final connectivityResult =
        await InternetAddress.lookup('google.com').timeout(
      const Duration(seconds: 4),
      onTimeout: () => throw Exception('no internet'),
    );

    if (!connectivityResult.isNotEmpty ||
        !connectivityResult[0].rawAddress.isNotEmpty) {
      throw Exception('no internet');
    }
    final List idsList = (await _theDatabase.query('paidAll',
        where: 'workerId=?',
        whereArgs: [userId],
        columns: ['id'],
        orderBy: 'id DESC',
        limit: 1));
    final int id = idsList.isEmpty ? 0 : idsList[0]['id'];

    final timestamp = DateTime.now();

    final token = (await _theDatabase
        .query('workers', where: 'id=?', whereArgs: [userId]))[0]['token'];
    _token ??= await TheDatabase.firebaseMessaging.getToken();
    _functions.httpsCallable('sendPaidAllRequest').call({
      'token': token as String,
      'workerId':userId.toString(),
      'shopToken': _token.toString(),
      'data': {
        'date': timestamp.toIso8601String(),
        'id': id.toString(),
        'amount': amount.toString(),
      },
      'messageBody': ' تصفية الحساب بمبلغ ${amount.toString()}'
    });
    await _theDatabase.insert('waiting_paidAll',
        {'date': timestamp.toIso8601String(), 'workerId': userId});
    _getFromLocaldatabase(true);
    // final id = await _theDatabase.insert('paidAll', {
    //   'amount': amount,
    //   'date': timestamp.toIso8601String(),
    //   'workerId': userId
    // });

    // await _fireStore
    //     .collection('/users')
    //     .doc('${map['name']}${map['shopName']}')
    //     .collection('/workers')
    //     .doc(userId.toString())
    //     .collection('/paidAll')
    //     .doc(timestamp.toIso8601String())
    //     .set({'amount': amount, 'id': id});

    // await _theDatabase
    //     .delete('work_data', where: 'workerId=?', whereArgs: [userId]);
    // _deleteWork(userId);
  }

  Future<void> addWork(bool ok, AddedWork addedWork, Function animate) async {
      final connectivityResult =
        await InternetAddress.lookup('google.com').timeout(
      const Duration(seconds: 4),
      onTimeout: () => throw Exception('no internet'),
    );

    if (!connectivityResult.isNotEmpty ||
        !connectivityResult[0].rawAddress.isNotEmpty) {
      throw Exception('no internet');
    }
    final map = (await _theDatabase.query('user'))[0];
    final String token = (await _theDatabase.query('workers',
        where: 'id=?', whereArgs: [addedWork.workerId]))[0]['token'] as String;
    String message =
        'تمت الموافقة على العمل بواسطة ${(map['name'] as String).replaceAll('_', ' ')}';

    if (!ok) {
      message = 'تم رفض العمل بواسطة ${map['name']}';
    }
    _functions.httpsCallable("responsForAddwork").call({
      'ok': ok,
      'senderId': "${map['name']}${map['shopName']}",
      'workerId': addedWork.workerId.toString(),
      'messageBody': ok
          ? 'تم اضافة ${addedWork.quantity} ${addedWork.type.name}'
          : 'تم رفض العمل:${addedWork.quantity} ${addedWork.type.name} ومبلغ  ${addedWork.amountSpent} ريال',
      'data': {
        'originalId': addedWork.originalId.toString(),
        'delete': ok ? '0' : '1'
      },
      'originalId': ok ? addedWork.originalId.toString() : "0",
      'date': addedWork.date.toIso8601String(),
      'amountSpent': addedWork.amountSpent.toString(),
      'quantity': addedWork.quantity,
      'typeName': addedWork.type.name,
      'token': token,
      'message': message,
    });
    await _theDatabase
        .delete('work_conformation', where: 'id=?', whereArgs: [addedWork.id]);
    _deleteAddWork(addedWork.id);
    if (ok) {
      final id = await _theDatabase.insert('work_data', {
        'quantity': addedWork.quantity,
        'amountSpent': addedWork.amountSpent,
        'date': addedWork.date.toIso8601String(),
        'typeName': addedWork.type.name,
        'workerId': addedWork.workerId
      });
      _addWorkLocally(
        DayWork(
            id: id,
            type: addedWork.type,
            quantity: addedWork.quantity,
            amountSpent: addedWork.amountSpent,
            date: addedWork.date),
        addedWork.workerId,
      );
    }
    _deleteAddWork(addedWork.id);
    animate();
    await const Duration(milliseconds: 200).delay();
    notifyListeners();
  }

//   Future<void> addWorkToFirebase() async {
//     try {
//       final Map<String, dynamic> map = (await _theDatabase.query('user'))[0];
//       final data = _fireStore
//           .collection('/users')
//           .doc(map['shopName'])
//           .collection('/_workers')
//           .doc(map['name'])
//           .collection('work');
//       for (var element in _unsupmittedList) {
//         await data.doc(element!.date.toIso8601String()).set({
//           'amountSpent': element.amountSpent,
//           'id': element.id,
//           'quantity': element.quantity,
//           'typeName': element.type.name,
//         }).timeout(
//           const Duration(milliseconds: 1200),
//           onTimeout: () => throw Error(),
//         );
//         await _theDatabase.update(
//             'work_data',
//             {
//               'hasBeenSubmitted': 1,
//             },
//             where: 'id=?',
//             whereArgs: [element.id]);
//       }
//     } catch (e) {
//       rethrow;
//     } finally {
//       notifyListeners();
//     }
//   }

//   Future<void> addOneWorkToFirebase(
//       {required int amountSpent,
//       required int quantity,
//       required String typeName}) async {
//     var hasBeenSubmitted = false;
//     final Map<String, dynamic> map = (await _theDatabase.query('user'))[0];
//     final datestamp = DateTime.now();
//     final id = await _theDatabase.insert('work_data', {
//       'quantity': quantity,
//       'amountSpent': amountSpent,
//       'hasBeenSubmitted': 0,
//       'date': DateTime.now().toIso8601String(),
//       'typeName': typeName
//     });

//     try {
//       final data = _fireStore
//           .collection('/users')
//           .doc(map['shopName'])
//           .collection('/_workers')
//           .doc(map['name'])
//           .collection('work');
//       await data.doc(datestamp.toIso8601String()).set({
//         'amountSpent': amountSpent,
//         'id': id,
//         'quantity': quantity,
//         'typeName': typeName,
//       }).timeout(const Duration(milliseconds: 1200));
//       await _theDatabase.update(
//           'work_data',
//           {
//             'hasBeenSubmitted': 1,
//           },
//           where: 'id=?',
//           whereArgs: [id]);
//       hasBeenSubmitted = true;
//     } catch (e) {
//       rethrow;
//     } finally {
//       _addWork(
//           amountSpent: amountSpent,
//           date: datestamp,
//           id: id,
//           quantity: quantity,
//           typeName: typeName,
//           hasBeenSubmitted: hasBeenSubmitted);
//       notifyListeners();
//     }
//   }

// Future<void> deleteAWork(int id)async{
//       final Map<String, dynamic> map = (await _theDatabase.query('user'))[0];
//       final theItem = _workDataList.firstWhere((element) => element!.id==id);
//       if(!theItem!.hasBeenSubmitted){
//          await _theDatabase.delete(
//           'work_data',
//           where: 'id=?',
//           whereArgs: [id]);
//            _deleteWork(id);
//       notifyListeners();
//       return;

//       }
//  try {
//       final data = _fireStore
//           .collection('/users')
//           .doc(map['shopName'])
//           .collection('/_workers')
//           .doc(map['name'])
//           .collection('work');
//       await data.doc(theItem.date.toIso8601String()).delete().timeout(const Duration(milliseconds: 1200));
//       await _theDatabase.delete(
//           'work_data',
//           where: 'id=?',
//           whereArgs: [id]);
//        _deleteWork(id);
//       notifyListeners();
//     } catch (e) {
//       rethrow;
//     }
// }
}
