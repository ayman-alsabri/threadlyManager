import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:statistics_maneger/main_screen/providers/work_data.dart';
import 'package:statistics_maneger/providers/database.dart';

class WorkContainer extends StatelessWidget {
  final List<DayWork> workList;
  const WorkContainer({required this.workList, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = WorkData.currenTheme;
  late final format =
      WorkData.formatNumbers;
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 40,left: 10,right: 10,top: 10),
        
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryContainer,
          borderRadius: const BorderRadiusDirectional.all(Radius.circular(30)),
        ),
        clipBehavior: Clip.hardEdge,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'valid data'.tr,
                    style: theme.textTheme.headlineSmall!
                        .copyWith(fontSize: 25),
                  ),
                ),
              ),
             
                Expanded(
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: workList.length,
                    itemBuilder: (context, index) {
                      final currentItem = workList[index];
                
                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        child: Column(
                          children: [
                            ListTile(
                              // onLongPress: () {
                                // if (DateTime.now()
                                //         .difference(currentItem.date)
                                //         .inMinutes >=
                                //     30) {
                                //   ScaffoldMessenger.of(context)
                                //       .hideCurrentSnackBar();
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //       SnackBar(
                                //           duration: const Duration(seconds: 2),
                                //           content: Text(
                                //               'you can\'t delete it. it\'s too old'
                                //                   .tr)));
                                //   return;
                                // }
                                // showDialog(
                                //   context: context,
                                //   builder: (context) => AlertDialog(
                                //     title:
                                //         Text('do you want to delete this item?'.tr),
                                //     actions: [
                                //       TextButton(
                                //         onPressed: () => Navigator.pop(context),
                                //         child: Text('cancle'.tr),
                                //       ),
                                //       TextButton(
                                //         onPressed: () async {
                                //           try {
                                //             await firebaseData
                                //                 .deleteAWork(currentItem.id);
                                //           } catch (e) {
                                //             if (!context.mounted) return;
                                //             ScaffoldMessenger.of(context)
                                //                 .hideCurrentSnackBar();
                                //             ScaffoldMessenger.of(context)
                                //                 .showSnackBar(
                                //               SnackBar(
                                //                 content: Text(
                                //                     'could not delete it right now,please try again.'
                                //                         .tr),
                                //               ),
                                //             );
                                //           } finally {
                                //             if (context.mounted) {
                                //               Navigator.pop(context);
                                //             }
                                //           }
                                //         },
                                //         child: Text('ok'.tr),
                                //       ),
                                //     ],
                                //   ),
                                // );
                              // },
                              splashColor: Colors.transparent,
                              title: FittedBox(
                                child: Text(
                                    DateFormat.EEEE(TheDatabase.localCode)
                                        .add_yMd()
                                        .format(currentItem.date),
                                    softWrap: false),
                              ),
                              trailing: FittedBox(
                                child: Column(
                                  children: [
                                    Text(
                                      '${'work: '.tr}${format.format(currentItem.quantity)} ${currentItem.type.name}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                    Text(
                                      'spent: '.tr +
                                          format.format(currentItem.amountSpent) +
                                          'ryals'.tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                    Text(
                                      'amount: '.tr +
                                          format.format((currentItem.quantity *
                                                  currentItem.type.price) -
                                              currentItem.amountSpent) +
                                          'ryals'.tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: theme.colorScheme.secondary,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
