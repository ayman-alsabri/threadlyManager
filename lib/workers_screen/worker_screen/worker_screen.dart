import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:statistics_maneger/main_screen/providers/work_data.dart';
import 'package:statistics_maneger/workers_screen/worker_screen/widgets/brief_container.dart';
import 'package:statistics_maneger/workers_screen/worker_screen/widgets/pay_all_sheet.dart';
import 'package:statistics_maneger/workers_screen/worker_screen/widgets/work_container.dart';

class WorkerScreen extends StatelessWidget {
  const WorkerScreen({super.key});
  static const route = 'worker_screen';

  int totalAmount(List<DayWork> validData) {
    int total = 0;
    for (var element in validData) {
      total += element.quantity * element.type.price;
    }
    return total;
  }

  int spentAmount(List<DayWork> validData) {
    int spent = 0;
    for (var element in validData) {
      spent += element.amountSpent;
    }
    return spent;
  }

  @override
  Widget build(BuildContext context) {
    final titleAndId = ModalRoute.of(context)!.settings.arguments as List;
    final theme = WorkData.currenTheme;
    final width = MediaQuery.sizeOf(context).width;
    final format = WorkData.formatNumbers;
    final worker = Provider.of<WorkData>(context).workersWork(titleAndId[0]);
    final WaitingPaidAll? waitingPaidAll = worker.waitingPaidAll;
    final workdata = worker.work;
    final total = totalAmount(workdata);
    final spent = spentAmount(workdata);
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAndId[0]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: (waitingPaidAll != null && waitingPaidAll.active)
              ? null
              : () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => PayAllSheet(
                          dueAmount: total - spent,
                          workersName: titleAndId[0],
                          usersId: titleAndId[1]),
                      backgroundColor: theme.scaffoldBackgroundColor,
                      elevation: 1);
                },
          child: Column(
            children: [
              Icon(
                Icons.add,
                color: theme.scaffoldBackgroundColor,
              ),
              FittedBox(
                child: Text(
                  'pay all'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: theme.scaffoldBackgroundColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          )),
      body: Stack(
        children: [
          Column(
            children: [
              Hero(
                  tag: titleAndId[0],
                  child: BreifContainer(
                      total: total,
                      spent: spent,
                      theme: theme,
                      format: format,
                      validData: workdata)),
              WorkContainer(workList: workdata)
            ],
          ),
          if (waitingPaidAll != null && waitingPaidAll.active)
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                child: Center(
                    child: FittedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: theme.colorScheme.secondary.withOpacity(0.3),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(
                          '  ${'waiting for a response'.tr}  ',
                          style: theme.textTheme.headlineMedium!.copyWith(
                              color: theme.colorScheme.secondary,
                              fontSize: 30,
                              shadows: [
                                Shadow(
                                    color: theme.colorScheme.onSecondary,
                                    blurRadius: 10)
                              ]),
                        ),
                        LoadingAnimationWidget.waveDots(
                            color: theme.colorScheme.secondary,
                            size: width * 0.2)
                      ],
                    ),
                  ),
                )),
              ),
            ),
        ],
      ),
    );
  }
}
