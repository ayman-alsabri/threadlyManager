import 'dart:async';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:statistics_maneger/auth_screen/providers/auth.dart';
import 'package:statistics_maneger/main_screen/home/home_page.dart';
import 'package:statistics_maneger/main_screen/notifications/notification_page.dart';
import 'package:statistics_maneger/main_screen/providers/firebase_data.dart';
import 'package:statistics_maneger/main_screen/widgets/add_sheet.dart';
import 'package:statistics_maneger/main_screen/widgets/bottom_bar.dart';
import 'package:statistics_maneger/providers/database.dart';
import 'package:statistics_maneger/main_screen/providers/work_data.dart';
import 'package:statistics_maneger/the_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const route = 'home/screen';

  Future _setAllData(FirebaseData firebaseData, WorkData workData,
      BuildContext context) async {
    await initializeDateFormatting(TheDatabase.localCode);
    try {
      await workData.getFromLocalDatabase(false);
      await firebaseData.hasPaid();
      if (TheDatabase.firstInit) {
        await firebaseData
            .getAndSetData()
            .then((value) => workData.getFromLocalDatabase(true));
        await TheDatabase.updateFirstInit();
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text('no internet connection or internet is very slow'.tr),
        ),
      );
    }
    if (TheDatabase.firstInit) return;
    firebaseData
        .getAndSetData()
        .then((value) => workData.getFromLocalDatabase(true))
        .catchError((error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text('no internet connection or internet is very slow'.tr),
        ),
      );
    });

    // await  workData.getFromLocalDatabase();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseData = Provider.of<FirebaseData>(context, listen: false);
    final workData = Provider.of<WorkData>(context, listen: false);
    final width = MediaQuery.sizeOf(context).width;
    return FutureBuilder(
        future: _setAllData(firebaseData, workData, context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Scaffold(
                    body: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/icons/threadlyManager.png',
                            color: WorkData.currenTheme.colorScheme.secondary,
                            width: 150,
                          ),
                          LoadingAnimationWidget.staggeredDotsWave(
                            color: WorkData.currenTheme.colorScheme.secondary,
                            size: width * 0.2,
                          ),
                        ],
                      ),
                    ),
                  )
                : firebaseData.getHasPaid
                    ? const ValidHomeScreen()
                    : const PaymentScreen());
  }
}

//

//payment screen

//
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.account_circle_outlined,
          size: 50,
        ),
        title: Text(TheDatabase.userName),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: Get.forceAppUpdate, icon: const Icon(Icons.sync))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/images/payment-background-${theme.brightness == Brightness.light ? 'black' : 'white'}.png'),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: FutureBuilder(
              future: TheDatabase.theDatabase.query('user'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                final amount = snapshot.data?[0]['paymentAmount'];
                final format = WorkData.formatNumbers;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Text(
                          'payment first'.tr,
                          style: theme.textTheme.headlineSmall,
                        ),
                        SizedBox(height: size.height * 0.03),
                        Text(
                          'firstDetails'.tr +
                              format.format(amount) +
                              'ryals'.tr +
                              'details'.tr,
                          style: theme.textTheme.labelLarge,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            // margin: const EdgeInsets.only(bottom: 80),
                            color: theme.colorScheme.primary.withOpacity(0.2),
                            width: size.width * 0.9,
                            child: Column(children: [
                              ListTile(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'scan to pay'.tr,
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Image.asset(
                                            'assets/images/extra/kuraimi.jpg'),
                                        actions: const [
                                          SelectableText('3006535177')
                                        ],
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                      );
                                    },
                                  );
                                },
                                leading: Image.asset(
                                    'assets/images/kuraimi-icon.png'),
                                title: Text(
                                  'kuraimi'.tr,
                                  style: theme.textTheme.labelMedium,
                                ),
                                subtitle: Text(
                                  'click for more information'.tr,
                                  style: theme.textTheme.labelSmall,
                                ),
                                trailing: const Icon(Icons.payment),
                              ),
                              ListTile(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'scan to pay'.tr,
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Image.asset(
                                            'assets/images/extra/jawali.jpg'),
                                      );
                                    },
                                  );
                                },
                                leading: Image.asset(
                                    'assets/images/jawali-icon.png'),
                                title: Text(
                                  'jawali'.tr,
                                  style: theme.textTheme.labelMedium,
                                ),
                                subtitle: Text(
                                  'click for more information'.tr,
                                  style: theme.textTheme.labelSmall,
                                ),
                                trailing: const Icon(Icons.payment),
                              ),
                              ListTile(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'scan to pay'.tr,
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Image.asset(
                                            'assets/images/extra/btc.jpg'),
                                        actions: const [
                                          SelectableText(
                                              'bc1qn6l84d44xgkvufv0n6lr7zdz2cgkw0kunyy7ds')
                                        ],
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                      );
                                    },
                                  );
                                },
                                leading: Image.asset(
                                    'assets/images/bitcoin-icon.png'),
                                title: Text(
                                  'bitcoin'.tr,
                                  style: theme.textTheme.labelMedium,
                                ),
                                subtitle: Text(
                                  'click for more information'.tr,
                                  style: theme.textTheme.labelSmall,
                                ),
                                trailing: const Icon(Icons.currency_bitcoin),
                              ),
                              ListTile(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'scan to pay'.tr,
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Image.asset(
                                            'assets/images/extra/usdt.jpg'),
                                        actions: const [
                                          SelectableText(
                                              '6fgCpH22RqwTvSRD5QMU82WCKYPpRfnEUnVmCkHqazDq')
                                        ],
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                      );
                                    },
                                  );
                                },
                                leading:
                                    Image.asset('assets/images/usdt-icon.png'),
                                title: Text(
                                  'usdt'.tr,
                                  style: theme.textTheme.labelMedium,
                                ),
                                subtitle: Text(
                                  'click for more information'.tr,
                                  style: theme.textTheme.labelSmall,
                                ),
                                trailing: const Icon(Icons.attach_money),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await auth.logout(false);
          },
          child: const Text('logout')),
    );
  }
}

//

// paid screen

//
@pragma('vm:entry-point')
Future<void> onBackgroundMessageHandaler(RemoteMessage message) async {
  Database theDatabase;
  String? title = message.notification?.title;
  String? body = message.notification?.body;

  try {
    theDatabase = TheDatabase.theDatabase;
  } catch (e) {
    theDatabase =
        await openDatabase('${await getDatabasesPath()}/statistics.db');
  }

  if (message.data.length == 6) {
    final data = message.data;
    await theDatabase.insert(
        'work_conformation',
        {
          'amountSpent': int.parse(data['amountSpent']),
          'oringinalId': int.parse(data['id']),
          'workerId': int.parse(data['workerId']),
          'date': data['date'],
          'quantity': int.parse(data['quantity']),
          'typeName': data['typeName'],
        },
        conflictAlgorithm: ConflictAlgorithm.replace);

    final workerName = ((await theDatabase.query('workers',
            where: 'id=?',
            whereArgs: [int.parse(data['workerId'])]))[0]['name'] as String)
        .replaceAll('_', ' ');
    title = 'تم اضافة عمل جديد بواسطة $workerName';
    body = ('تم اضافة ${data['quantity']} ${data['typeName']}');
  }
  if (message.data.length == 4) {
    final delete = int.parse(message.data['delete']);
    final workerId = int.parse(message.data['workerId']);
    final amount = int.parse(message.data['amount']);
    final date = (message.data['date']);
    if (delete == 1) {
      await theDatabase
          .delete('work_data', where: 'workerId=?', whereArgs: [workerId]);
      await theDatabase.insert(
          'paidAll', {'amount': amount, 'workerId': workerId, 'date': date});
    }
    await theDatabase
        .delete('waiting_paidAll', where: 'workerId=?', whereArgs: [workerId]);

    final workerName = ((await theDatabase.query('workers',
            where: 'id=?', whereArgs: [workerId]))[0]['name'] as String)
        .replaceAll('_', ' ');
    title = delete == 1
        ? 'تمت الموافقة على تصفية الحساب من قبل: $workerName'
        : 'تم رفض تصفية الحساب من قبل: $workerName';
    body = '${'المبلغ:'} $amount';
  }
  if (message.data.length == 3) {
    final workerId = int.parse(message.data['id']);
    final name = message.data['name'];
    final workerToken = message.data['token'];

    await theDatabase.insert(
        'workers', {'id': workerId, 'name': name, 'token': workerToken},
        conflictAlgorithm: ConflictAlgorithm.replace);
    title = 'تم اضافة عامل جديد';
    body = 'قل مرحبا لـ $name';
  }
  if (message.data.length == 1) {
    if (message.data['workerId'] == null) return;
    final workerId = int.parse(message.data['workerId']);
    await theDatabase
        .delete('waiting_paidAll', where: 'workerId=?', whereArgs: [workerId]);

    title = 'خطأ. لم يتم تسليم الطلب';
    body = 'تأكد أن التطبيق مثبت لدى المستخدم';
  }

  FlutterLocalNotificationsPlugin().show(
    message.messageId?.hashCode ?? 1,
    title,
    body,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'default_notification_channel_id', 'High Importance Notifications',
        // color: WorkData.currenTheme.colorScheme.secondary
      ),
    ),
  );
}

class ValidHomeScreen extends StatefulWidget {
  const ValidHomeScreen({super.key});

  @override
  State<ValidHomeScreen> createState() => _ValidHomeScreenState();
}

class _ValidHomeScreenState extends State<ValidHomeScreen>
    with WidgetsBindingObserver {
  late final _controller = PageController();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _workData.getFromLocalDatabase(true);
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessageHandaler);
    FirebaseMessaging.onMessage.listen((message) async {
      final theDatabase = TheDatabase.theDatabase;
      String? title = message.notification?.title;
      String? body = message.notification?.body;

      if (message.data.length == 6) {
        final data = message.data;
        await theDatabase.insert(
            'work_conformation',
            {
              'amountSpent': int.parse(data['amountSpent']),
              'oringinalId': int.parse(data['id']),
              'workerId': int.parse(data['workerId']),
              'date': data['date'],
              'quantity': int.parse(data['quantity']),
              'typeName': data['typeName'],
            },
            conflictAlgorithm: ConflictAlgorithm.replace);

        final workerName = ((await theDatabase.query('workers',
                where: 'id=?',
                whereArgs: [int.parse(data['workerId'])]))[0]['name'] as String)
            .replaceAll('_', ' ');
        title = 'تم اضافة عمل جديد بواسطة $workerName';
        body = ('تم اضافة ${data['quantity']} ${data['typeName']}');
      }
      if (message.data.length == 4) {
        final delete = int.parse(message.data['delete']);
        final workerId = int.parse(message.data['workerId']);
        final amount = int.parse(message.data['amount']);
        final date = (message.data['date']);
        if (delete == 1) {
          await theDatabase
              .delete('work_data', where: 'workerId=?', whereArgs: [workerId]);
          await theDatabase.insert('paidAll',
              {'amount': amount, 'workerId': workerId, 'date': date});
        }
        await theDatabase.delete('waiting_paidAll',
            where: 'workerId=?', whereArgs: [workerId]);

        final workerName = ((await theDatabase.query('workers',
                where: 'id=?', whereArgs: [workerId]))[0]['name'] as String)
            .replaceAll('_', ' ');
        title = delete == 1
            ? 'تمت الموافقة على تصفية الحساب من قبل: $workerName'
            : 'تم رفض تصفية الحساب من قبل: $workerName';
        body = '${'المبلغ:'} $amount';
      }
      if (message.data.length == 3) {
        final workerId = int.parse(message.data['id']);
        final name = message.data['name'];
        final workerToken = message.data['token'];

        await theDatabase.insert(
            'workers', {'id': workerId, 'name': name, 'token': workerToken},
            conflictAlgorithm: ConflictAlgorithm.replace);
        title = 'تم اضافة عامل جديد';
        body = 'قل مرحبا بـ $name';
      }
      if (message.data.length == 1) {
        if (message.data['workerId'] == null) return;
        final workerId = int.parse(message.data['workerId']);
        await theDatabase.delete('waiting_paidAll',
            where: 'workerId=?', whereArgs: [workerId]);
        title = 'خطأ. لم يتم تسليم الطلب';
        body = 'تأكد أن التطبيق مثبت لدى المستخدم';
      }

      FlutterLocalNotificationsPlugin().show(
        message.messageId?.hashCode ?? 1,
        title,
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'default_notification_channel_id',
            'High Importance Notifications',
            // color: WorkData.currenTheme.colorScheme.secondary
          ),
        ),
      );
      await _workData.getFromLocalDatabase(true);
    });
  }

  bool _animation = false;
  bool _isSyncing = false;

  late final _firebaseData = Provider.of<FirebaseData>(context, listen: false);
  late final _workData = Provider.of<WorkData>(context, listen: false);
  late final _theme = WorkData.currenTheme;
  int _selected = 0;
  final List _pages = [
    {'body': const Text('home'), 'title': 'work data'.tr},
    {'body': const Text('history'), 'title': 'notification'.tr},
  ];

  void _onTap(int index) async {
    if (index != _selected) {
      setState(() {
        _animation = true;
      });

      index == 1
          ? await _controller.nextPage(
              duration: const Duration(milliseconds: 300), curve: Curves.linear)
          : await _controller.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
    }
    setState(() {
      _animation = false;
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: 'open drawer'.tr,
          );
        }),
        title: AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: _animation ? 0 : 1,
            child: Text(_pages[_selected]['title'])),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: _isSyncing
                  ? () {}
                  : () async {
                      setState(() {
                        _isSyncing = true;
                      });
                      try {
                        await _firebaseData.getAndSetData();
                        await _workData.getFromLocalDatabase(true);
                      } catch (e) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('can\'t sync now, please try again'.tr),
                          ),
                        );
                      } finally {
                        setState(() {
                          _isSyncing = false;
                        });
                      }
                      // firebasedata.getAndSetData();
                    },
              icon: _isSyncing
                  ? Icon(
                      Icons.sync_lock,
                      color: _theme.colorScheme.primary.withOpacity(0.5),
                    )
                  : const Icon(Icons.sync),
              tooltip: 'sync'.tr,
            );
          })
        ],
      ),
      body: PageView(
        onPageChanged: _onTap,
        controller: _controller,
        children: const [
          (Homepage()),
          (NotificationPage()),
        ],
      ),
      drawer: const TheDrawer(),
      bottomNavigationBar: BottomBar(selected: _selected, onTap: _onTap),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => const AddSheet(),
              backgroundColor: _theme.scaffoldBackgroundColor,
              elevation: 1);

          // FirebaseAuth.instance.signOut();
        },
        child: Column(
          children: [
            Icon(
              Icons.add,
              color: _theme.scaffoldBackgroundColor,
            ),
            Text(
              'type'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: _theme.scaffoldBackgroundColor,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
