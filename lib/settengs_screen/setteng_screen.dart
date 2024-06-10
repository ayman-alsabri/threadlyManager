import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:statistics_maneger/providers/theme.dart';
import 'package:statistics_maneger/providers/database.dart';
import 'package:statistics_maneger/main_screen/providers/work_data.dart';

class SettengsScreen extends StatelessWidget {
  const SettengsScreen({super.key});
  static const route = 'settengs/screen';

  Hero listTileBuilder(
    IconData icon,
    String title,
    Widget onPressed,
    BuildContext context,
    ThemeData theme,
  ) {
    return Hero(
      tag: title,
      child: Material(
        child: GestureDetector(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: theme.colorScheme.secondaryContainer.withOpacity(0.4),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    icon,
                    color: theme.colorScheme.tertiary,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        title.tr,
                        style: TextStyle(
                          color: theme.colorScheme.tertiary,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () => Navigator.push(
            context,
            PageRouteBuilder(
              reverseTransitionDuration: const Duration(milliseconds: 20),
              barrierDismissible: true,
              opaque: false,
              pageBuilder: (context, animation, secondaryAnimation) => Hero(
                tag: title,
                child: FittedBox(
                  child: Theme(
                    data: theme.copyWith(
                      radioTheme: RadioThemeData(
                        fillColor: MaterialStatePropertyAll(
                            theme.colorScheme.onPrimary),
                        overlayColor: MaterialStatePropertyAll(
                            theme.colorScheme.onPrimary),
                      ),
                      listTileTheme: ListTileThemeData(
                        leadingAndTrailingTextStyle: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onPrimary),
                      ),
                    ),
                    child: onPressed,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final thedatabase = TheDatabase.theDatabase;
    final theme = WorkData.currenTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('settengs'.tr),
      ),
      body: ListView(
        children: [
          listTileBuilder(
            Icons.color_lens,
            'theme',
            const ThemeDialog(),
            context,
            theme,
          ),
          listTileBuilder(
            WorkData.currenTheme.brightness == Brightness.light
                ? Icons.dark_mode
                : Icons.light_mode,
            'theme mode',
            const ThemeModeDialog(),
            context,
            theme,
          ),
          listTileBuilder(
            Icons.language,
            'languages',
            AlertDialog(
              title: Text('languages'.tr),
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:

                      // content: const SizedBox(),
                      [
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await thedatabase.update('user', {'localCode': 'ar_EG'},
                            where: 'id=1',
                            conflictAlgorithm: ConflictAlgorithm.replace);
                        await TheDatabase.updatelocal();
                        await Get.updateLocale(const Locale('ar', 'EG'));
                        if (!context.mounted) return;
                      },
                      child: const Text('العربية'),
                    ),
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await thedatabase.update(
                              'user', {'localCode': 'en_US'},
                              where: 'id=1',
                              conflictAlgorithm: ConflictAlgorithm.replace);
                          await TheDatabase.updatelocal();
                          await Get.updateLocale(const Locale('en', 'US'));
                        },
                        child: const Text('english'))
                  ]),
            ),
            context,
            theme,
          ),
        ],
      ),
    );
  }
}



class ThemeDialog extends StatefulWidget {
  const ThemeDialog({
    super.key,
  });

  @override
  State<ThemeDialog> createState() => _ThemeDialogState();
}

class _ThemeDialogState extends State<ThemeDialog> {
  late int groupValue;

  @override
  void initState() {
    super.initState();
    if (TheDatabase.themes == AppTheme.golden) {
      groupValue = 0;
      return;
    }
    if (TheDatabase.themes == AppTheme.grey) {
      groupValue = 1;
      return;
    }
    if (TheDatabase.themes == AppTheme.blue) {
      groupValue = 2;
      return;
    }
    if (TheDatabase.themes == AppTheme.brown) {
      groupValue = 3;
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('theme'.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Text(
              'golden'.tr,
            ),
            trailing: Radio(
              value: 0,
              groupValue: groupValue,
              onChanged: (value) => setState(() {
                groupValue = value!;
              }),
            ),
          ),
          ListTile(
            leading: Text(
              'grey'.tr,
            ),
            trailing: Radio(
              value: 1,
              groupValue: groupValue,
              onChanged: (value) => setState(() {
                groupValue = value!;
              }),
            ),
          ),
          ListTile(
            leading: Text(
              'blue'.tr,
            ),
            trailing: Radio(
              value: 2,
              groupValue: groupValue,
              onChanged: (value) => setState(() {
                groupValue = value!;
              }),
            ),
          ),
          ListTile(
            leading: Text(
              'brown'.tr,
            ),
            trailing: Radio(
              value: 3,
              groupValue: groupValue,
              onChanged: (value) => setState(() {
                groupValue = value!;
              }),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('cancle'.tr)),
        TextButton(
            onPressed: () async {
              String databasemessage = 'golden';

              switch (groupValue) {
                case 0:
                  databasemessage = 'golden';
                  break;
                case 1:
                  databasemessage = 'grey';
                  break;
                case 2:
                  databasemessage = 'blue';
                  break;
                case 3:
                  databasemessage = 'brown';
                  break;
              }

              await TheDatabase.theDatabase.update(
                  'user', {'theme': databasemessage},
                  where: 'id=1', conflictAlgorithm: ConflictAlgorithm.replace);
              await TheDatabase.updateTheme();
              await Get.forceAppUpdate();
              // Get.changeThemeMode(themeMode);
              if (!context.mounted) return;
              Navigator.pop(context);
            },
            child: Text('ok'.tr)),
      ],
    );
  }
}

//
//
//
//
//
//
//
//

class ThemeModeDialog extends StatefulWidget {
  const ThemeModeDialog({
    super.key,
  });

  @override
  State<ThemeModeDialog> createState() => _ThemeModeDialogState();
}

class _ThemeModeDialogState extends State<ThemeModeDialog> {
  late int groupValue;
  @override
  void initState() {
    super.initState();
    final int groupValuedummy;
    switch (TheDatabase.themeMode) {
      case ThemeMode.system:
        groupValuedummy = 0;
        break;
      case ThemeMode.dark:
        groupValuedummy = 2;
        break;
      case ThemeMode.light:
        groupValuedummy = 1;
        break;
    }
    groupValue = groupValuedummy;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('theme mode'.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Text(
              'auto'.tr,
            ),
            trailing: Radio(
              value: 0,
              groupValue: groupValue,
              onChanged: (value) => setState(() {
                groupValue = value!;
              }),
            ),
          ),
          ListTile(
            leading: Text(
              'light'.tr,
            ),
            trailing: Radio(
              value: 1,
              groupValue: groupValue,
              onChanged: (value) => setState(() {
                groupValue = value!;
              }),
            ),
          ),
          ListTile(
            leading: Text(
              'dark'.tr,
            ),
            trailing: Radio(
              value: 2,
              groupValue: groupValue,
              onChanged: (value) => setState(() {
                groupValue = value!;
              }),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('cancle'.tr)),
        TextButton(
            onPressed: () async {
              String databasemessage = 'auto';

              switch (groupValue) {
                case 0:
                  databasemessage = 'auto';
                  break;
                case 1:
                  databasemessage = 'light';
                  break;
                case 2:
                  databasemessage = 'dark';
                  break;
              }

              await TheDatabase.theDatabase.update(
                  'user', {'themeMode': databasemessage},
                  where: 'id=1', conflictAlgorithm: ConflictAlgorithm.replace);
              await TheDatabase.updateThemeMode();
              await Get.forceAppUpdate();
              // Get.changeThemeMode(themeMode);
              if (!context.mounted) return;
              Navigator.pop(context);
            },
            child: Text('ok'.tr)),
      ],
    );
  }
}
