import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:statistics_maneger/main_screen/providers/firebase_data.dart';
import 'package:statistics_maneger/main_screen/providers/work_data.dart';

class PayAllSheet extends StatefulWidget {
  final String workersName;
  final int usersId;
  final int dueAmount;
  const PayAllSheet(
      {required this.usersId,
      required this.dueAmount,
      required this.workersName,
      super.key});

  @override
  State<PayAllSheet> createState() => _AddSheetState();
}

class _AddSheetState extends State<PayAllSheet> {
  bool _isloading = false;
  late final bool _cantSubmit = Provider.of<WorkData>(context, listen: false)
      .haveAddedWork(widget.usersId);

  final _theme = WorkData.currenTheme;
  late final _firebase = Provider.of<FirebaseData>(context, listen: false);
  final _format = WorkData.formatNumbers;

  Future<void> _submit() async {
    if (_cantSubmit) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${widget.workersName} ${'has work that\'s not accepted yet'.tr}'),
        ),
      );
      return;
    }
    final contin = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text('do you want to pay for:'.tr),
        content: Text(
            '${widget.workersName}: ${_format.format(widget.dueAmount)}${'ryals'.tr}${widget.dueAmount < 0 ? '\nnote: its in minus'.tr : ''}'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('ok'.tr)),
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('cancle'.tr)),
        ],
      ),
    );

    if (contin != true) return;
    setState(() {
      _isloading = true;
    });
    try {
      await _firebase.addPayment(widget.usersId, widget.dueAmount);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('could not add. please try again'.tr)));
    } finally {
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 2,
                        child: Text(
                          'worker'.tr,
                          style: TextStyle(
                              color: _theme.colorScheme.secondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        )),
                    Flexible(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: _theme.colorScheme.onPrimary)),
                          child: FittedBox(
                            child: Text(
                              (widget.workersName),
                              style: TextStyle(
                                  color: _theme.colorScheme.secondary),
                            ),
                          ),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: FittedBox(
                        child: Text(
                          'price'.tr,
                          style: TextStyle(
                              color: _theme.colorScheme.secondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: _theme.colorScheme.onPrimary)),
                        child: Text(
                          (_format.format(widget.dueAmount)),
                          style: TextStyle(color: _theme.colorScheme.secondary),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'cancle'.tr,
                      style: TextStyle(color: _theme.colorScheme.onSecondary),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _isloading
                        ? () {}
                        : widget.dueAmount == 0
                            ? null
                            : () => _submit(),
                    child: _isloading
                        ? const CircularProgressIndicator()
                        : Text(
                            'add'.tr,
                            style: TextStyle(
                                color: _theme.colorScheme.onSecondary),
                          ),
                  ),
                ],
              )),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
