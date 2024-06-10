import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:statistics_maneger/auth_screen/providers/auth.dart';
import 'package:statistics_maneger/providers/database.dart';
import 'package:statistics_maneger/main_screen/providers/work_data.dart';
import 'package:statistics_maneger/settengs_screen/setteng_screen.dart';
import 'package:statistics_maneger/workers_screen/workers_screen.dart';

class TheDrawer extends StatelessWidget {
  const TheDrawer({super.key});

  Hero _listTileBuilder(
    IconData icon,
    String title,
    Widget onPressed,
    BuildContext context,
    ThemeData theme,
  ) {
    return Hero(
      tag: title,
      child: Material(
        child: ListTile(
          leading: Icon(icon),
          title: Text(title.tr),
          onTap: () => Navigator.push(
              context,
              PageRouteBuilder(
                reverseTransitionDuration: const Duration(milliseconds: 20),
                barrierDismissible: true,
                opaque: false,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    Hero(tag: title, child: FittedBox(child: onPressed)),
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = WorkData.currenTheme;
    return Drawer(
      elevation: 0,
      child: SafeArea(
        child: Column(
          children: [
            AppBar(
              title: SelectableText(TheDatabase.userName),
              leading: const Icon(
                Icons.account_circle,
                size: 50,
              ),
              actions: [
                IconButton(
                    onPressed: () async {
                      await Clipboard.setData(
                          ClipboardData(text: TheDatabase.userName));
                      Fluttertoast.showToast(msg: 'copyed successfully'.tr);
                    },
                    icon: const Icon(Icons.copy))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text('settengs'.tr),
                    onTap: () {
                      Navigator.pushNamed(context, SettengsScreen.route);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.people),
                    title: Text('workers'.tr),
                    onTap: () {
                      Navigator.pushNamed(context, WorkersScreen.route);
                    },
                  ),
                  _listTileBuilder(
                    Icons.logout,
                    'logout',
                    AlertDialog(
                      title: Text('logout'.tr),
                      content: Text('are you sure you want to logout'.tr),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('cancle'.tr)),
                        TextButton(
                            onPressed: () async {
                              await Provider.of<Auth>(context, listen: false)
                                  .logout(false);
                              if(!context.mounted)return;
                              Navigator.pop(context);
                            },
                            child: Text('ok'.tr)),
                      ],
                    ),
                    context,
                    theme,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
