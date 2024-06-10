import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:intl/intl.dart';
import 'package:statistics_maneger/providers/database.dart';
// import 'package:usage_track/providers/database.dart';

class WorkData with ChangeNotifier {
  final _database = TheDatabase.theDatabase;

  List<Worker> _workers = [];
  List<AddedWork> _addWork = [];
  List<ItemType?> _itemTypes = [];

  List<Worker> get workers {
    return [..._workers];
  }

  List<AddedWork> get addedWork {
    return [..._addWork];
  }

  List<ItemType?> get itemTypes {
    return [..._itemTypes];
  }

  List<Map<String, DayWork>> get todaysWork {
    List<Map<String, DayWork>> tempList = [];
    final currentDate = DateTime.now();
    for (var worker in _workers) {
      final worklist = worker.work.reversed.toList();
      for (int a = 0; a < 6; a++) {
        if (a < worklist.length) {
          final dayWork = worklist[a];
          if (dayWork.date.day == currentDate.day) {
            tempList.add({worker.name: dayWork});
          }
        }
      }
    }

    return tempList;
  }

  String workerName(int id) {
    return _workers.firstWhere((element) => element.id == id).name.replaceAll('_',' ');
  }

  Worker workersWork(String workerName) {
    final worker = _workers.firstWhere((element) => element.name == workerName);
    return worker;
  }

  Future<void> deleteWork(int workerId) async {
    for (var element in _workers) {
      if (element.id == workerId) {
        element.work = [];
      }
    }
    notifyListeners();
  }

  void addWorkLocally(DayWork work, int workerId) {
    _workers.firstWhere((element) => element.id == workerId).work.add(work);
  }

  Future<void> deleteAddedWork(int id) async {
    _addWork.removeWhere((element) => element.id == id);
  }

  Future<void> getFromLocalDatabase(bool notifiy) async {
// get deafault item types
    final listTypes = await _database.query('types');
    List<ItemType> tempItems = [];

    for (var element in listTypes) {
      tempItems.add(ItemType(
        id: element['id'] as int,
        name: element['name'] as String,
        price: element['price'] as int,
      ));
    }
    if (tempItems.isEmpty) return;

    _itemTypes = tempItems;

//get daywork list
    final tempWorkers = await _database.query('workers');
    //second has small W
    final List<Worker> tempworkers = [];
    for (var element in tempWorkers) {
      final List<DayWork> work = [];
      final List<PaidALL> payments = [];
      WaitingPaidAll? waitingPaidAll;

      final waitingElementFromdb = await _database.query('waiting_paidAll',
          where: 'workerId=?', whereArgs: [element['id']]);
      if (waitingElementFromdb.isNotEmpty) {
        waitingPaidAll = WaitingPaidAll(
          date: DateTime.parse(waitingElementFromdb[0]['date'] as String),
          active: true,
        );
      }

      for (var daywork in (await _database.query('work_data',
              where: 'workerId=?', whereArgs: [element['id']]))
          //
          ) {
        work.add(DayWork(
          id: daywork['id'] as int,
          type: _itemTypes
              .firstWhere((type) => type?.name == daywork['typeName'])!,
          quantity: daywork['quantity'] as int,
          amountSpent: daywork['amountSpent'] as int,
          date: DateTime.parse(daywork['date'] as String),
        ));
      }

      for (var payment in (await _database
          .query('paidAll', where: 'workerId=?', whereArgs: [element['id']]))) {
        payments.add(PaidALL(
          id: payment['id'] as int,
          amount: payment['amount'] as int,
          date: DateTime.parse(payment['date'] as String),
        ));
        // if (waitingElementFromdb.isNotEmpty &&
        //     payment['date'] == waitingElementFromdb[0]['date']) {
        //   print('deleted niggger\n\n');
        //   await _database.delete('work_data',
        //       where: 'workerId=?', whereArgs: [element['id']]);
        //   await _database.delete('waiting_paidAll',
        //       where: 'workerId=?', whereArgs: [element['id']]);
        //   waitingPaidAll = null;
        // }
      }

      tempworkers.add(Worker(
        waitingPaidAll: waitingPaidAll,
        name: element['name'] as String,
        id: element['id'] as int,
        work: work,
        payments: payments,
      ));
      // if (waitingPaidAll != null &&
      //     waitingPaidAll.date
      //         .isBefore(DateTime.now().subtract(const Duration(days: 7 * 4)))) {
      //   await _database.delete('waiting_paidAll',
      //       where: 'workerId=?', whereArgs: [element['id']]);
      //   waitingPaidAll = null;
      // }
    }
    _workers = tempworkers;

    final List<AddedWork> tempAddWork = [];
    for (var element in (await _database.query('work_conformation'))) {
      tempAddWork.add(AddedWork(
          id: element['id'] as int,
          type: _itemTypes.firstWhere(
              (type) => type!.name == element['typeName'] as String)!,
          quantity: element['quantity'] as int,
          amountSpent: element['amountSpent'] as int,
          date: DateTime.parse(element['date'] as String),
          workerId: element['workerId'] as int,
          originalId: element['oringinalId'] as int));
    }
    _addWork = tempAddWork;

    // final List<AddedWork> deleted = [];
    // for (var element in _addWork) {
    //   if (element.date
    //       .isBefore(DateTime.now().subtract(const Duration(days: 7 * 4)))) {
    //     await _database.delete('work_conformation',
    //         where: 'id=?', whereArgs: [element.id]);
    //     deleted.add(element);
    //   }
    // }
    // for (var element in deleted) {
    //   _addWork.remove(element);
    // }
    if (notifiy) {
      notifyListeners();
    }
  }

  void addType(ItemType type, bool edit) {
    if (!edit) {
      _itemTypes.add(type);
    }
    else{
      _itemTypes[_itemTypes.indexWhere((element) => element!.name == type.name)]=type;
    }

    notifyListeners();
  }

  bool haveAddedWork(int userid) {
    for (var element in _addWork) {
      if (element.workerId == userid) {
        return true;
      }
    }
    return false;
  }
  //numberFormat and currentTheme

  static NumberFormat get formatNumbers {
    return NumberFormat('##,###,###.##', TheDatabase.localCode);
  }

  static ThemeData get currenTheme {
    // return AppTheme.darkTheme;
    switch (TheDatabase.themeMode) {
      case ThemeMode.system:
        {
          var brightness =
              SchedulerBinding.instance.platformDispatcher.platformBrightness;
          switch (brightness) {
            case Brightness.dark:
              return TheDatabase.themes[1];
            case Brightness.light:
              return TheDatabase.themes[0];
          }
        }
      case ThemeMode.light:
        return TheDatabase.themes[0];
      case ThemeMode.dark:
        return TheDatabase.themes[1];
    }
  }
}

// all final for the shop owner to provide in order to force them to buy
class ItemType {
  final String name;
  final int price;
  final int id;

  ItemType({
    required this.id,
    required this.name,
    required this.price,
  });
}

//all final in order to not change and cheate
class DayWork {
  final ItemType type;
  final int quantity;
  final int amountSpent;
  final DateTime date;
  final int id;

  DayWork({
    required this.id,
    required this.type,
    required this.quantity,
    required this.amountSpent,
    required this.date,
  });
}

class AddedWork {
  final ItemType type;
  final int quantity;
  final int amountSpent;
  final DateTime date;
  final int id;
  final int originalId;
  final int workerId;

  AddedWork({
    required this.id,
    required this.type,
    required this.quantity,
    required this.amountSpent,
    required this.date,
    required this.originalId,
    required this.workerId,
  });
}

class PaidALL {
  final DateTime date;
  final int amount;
  final int id;

  PaidALL({
    required this.id,
    required this.amount,
    required this.date,
  });
}

class WaitingPaidAll {
  final DateTime date;
  bool active;

  WaitingPaidAll({
    this.active = false,
    required this.date,
  });
}

class Worker {
  final int id;
  final String name;
  WaitingPaidAll? waitingPaidAll;
  List<DayWork> work;
  List<PaidALL> payments;

  Worker({
    required this.name,
    required this.id,
    required this.waitingPaidAll,
    this.work = const [],
    this.payments = const [],
  });
}
