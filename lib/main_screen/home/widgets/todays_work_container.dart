import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:statistics_maneger/main_screen/providers/work_data.dart';

class TodaysWorkContainet extends StatefulWidget {
  const TodaysWorkContainet({super.key});

  @override
  State<TodaysWorkContainet> createState() => _TodaysWorkContainetState();
}

class _TodaysWorkContainetState extends State<TodaysWorkContainet> {
  bool _isNotExpanded = true;
  final _theme = WorkData.currenTheme;
  final _format = WorkData.formatNumbers;
  late final _size = MediaQuery.sizeOf(context);
  @override
  Widget build(BuildContext context) {
    final todaysWork = Provider.of<WorkData>(context).todaysWork;

    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      duration: const Duration(milliseconds: 300),
      constraints: BoxConstraints(maxHeight: _size.height * 0.6),
      height: _isNotExpanded
          ? _size.height * 0.2
          : todaysWork.length * 70 + _size.height * 0.2,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: _theme.scaffoldBackgroundColor.withOpacity(0.5),
              blurRadius: 1,
              offset: const Offset(0, -3))
        ],
        color: _theme.colorScheme.secondaryContainer,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                _isNotExpanded = !_isNotExpanded;
              });
            },
            icon: Icon(_isNotExpanded ? Icons.expand_less : Icons.expand_more),
          ),
          todaysWork.isEmpty
              ? Center(child: Text('data'.tr))
              : Expanded(
                  child: ListView.builder(
                    physics: _isNotExpanded
                        ? const NeverScrollableScrollPhysics()
                        : null,
                    itemCount: todaysWork.length,
                    itemBuilder: (context, index) {
                      final currentItem = todaysWork[index].values.first;
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: _theme.scaffoldBackgroundColor
                                .withOpacity(0.2)),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(8),
                        child: ListTile(
                          title: FittedBox(fit: BoxFit.scaleDown,
                              child: Text(todaysWork[index].keys.first)),
                          trailing: FittedBox(
                            child: Column(
                              children: [
                                Text(
                                  '${'work: '.tr}${_format.format(currentItem.quantity)} ${currentItem.type.name}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                                Text(
                                  'spent: '.tr +
                                      _format.format(currentItem.amountSpent) +
                                      'ryals'.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                                Text(
                                  'amount: '.tr +
                                      _format.format((currentItem.quantity *
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
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }
}
