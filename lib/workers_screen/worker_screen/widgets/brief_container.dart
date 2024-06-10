import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:statistics_maneger/main_screen/providers/work_data.dart';

class BreifContainer extends StatelessWidget {
  final int  total;
  final int  spent;

  final ThemeData theme;
  final NumberFormat format;
  final List<DayWork?> validData;
  const BreifContainer({

    super.key,
    required this.spent,
    required this.total,
    required this.theme,
    required this.format,
    required this.validData,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height * 2 / 12,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 6,
                fit: FlexFit.loose,
                child: FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                          child: Text(
                        'total amount:'.tr + format.format(total) + 'ryals'.tr,
                        style: theme.textTheme.headlineMedium,
                        softWrap: false,
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      FittedBox(
                          child: Text(
                        'spent amount:'.tr + format.format(spent) + 'ryals'.tr,
                        style: theme.textTheme.headlineMedium,
                        softWrap: false,
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      FittedBox(
                          child: Text(
                        'net amount:'.tr +
                            format.format(total - spent) +
                            'ryals'.tr,
                        style: theme.textTheme.headlineMedium,
                        softWrap: false,
                      )),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: FittedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('avrage income'.tr,
                            style:
                                TextStyle(color: theme.colorScheme.secondary)),
                        Text(
                            format.format(total == 0
                                    ? 0
                                    : (((total - spent) /
                                                (validData.length * 100))
                                            .round() *
                                        100)) +
                                'ryals'.tr,
                            style:
                                TextStyle(color: theme.colorScheme.secondary)),
                        Text('avrage outcome'.tr,
                            style:
                                TextStyle(color: theme.colorScheme.secondary)),
                        Text(
                            format.format(total == 0
                                    ? 0
                                    : (((spent) / (validData.length * 100))
                                            .round() *
                                        100)) +
                                'ryals'.tr,
                            style:
                                TextStyle(color: theme.colorScheme.secondary)),
                        Text('avrage work'.tr,
                            style:
                                TextStyle(color: theme.colorScheme.secondary)),
                        Text(format.format(totalWork()),
                            style:
                                TextStyle(color: theme.colorScheme.secondary)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  int totalWork() {
    int work = 0;
    for (var element in validData) {
      work += element!.quantity;
    }
    return work;
  }
}
