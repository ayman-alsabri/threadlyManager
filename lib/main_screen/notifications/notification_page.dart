import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:statistics_maneger/main_screen/providers/firebase_data.dart';
import 'package:statistics_maneger/main_screen/providers/work_data.dart';
import 'package:statistics_maneger/providers/database.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = TheDatabase.localCode;
    final workData = Provider.of<WorkData>(context);
    final firebase = Provider.of<FirebaseData>(context);
    final notificationList = workData.addedWork;
    final theme = WorkData.currenTheme;
    final size = MediaQuery.sizeOf(context);
    final format = WorkData.formatNumbers;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: notificationList.length,
      itemBuilder: (context, index) => CustomAnimated(
          key: UniqueKey(),
          size: size,
          theme: theme,
          workData: workData,
          addedWork: notificationList[index],
          format: format,
          local: local,
          firebase: firebase),
    );
  }
}

class CustomAnimated extends StatefulWidget {
  const CustomAnimated({
    super.key,
    required this.size,
    required this.theme,
    required this.workData,
    required this.addedWork,
    required this.format,
    required this.local,
    required this.firebase,
  });

  final Size size;
  final ThemeData theme;
  final WorkData workData;
  final AddedWork addedWork;
  final NumberFormat format;
  final String local;
  final FirebaseData firebase;

  @override
  State<CustomAnimated> createState() => _CustomAnimatedState();
}

class _CustomAnimatedState extends State<CustomAnimated> {
  bool _isloading = false;
  bool _animate = false;

  void startAnimation() {
    setState(() {
      _animate = true;
    });
  }

  Future<void> _submit(bool ok) async {
    if (ok) {
      setState(() {
        _isloading = true;
      });
    }
    try {
      await widget.firebase.addWork(ok, widget.addedWork, startAnimation);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('can\'t load now, please try again'.tr),
        ),
      );
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      key: widget.key,
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(10),
      margin: _animate
          ? EdgeInsets.symmetric(
              vertical: 10, horizontal: widget.size.width * 0.5 - 5)
          : const EdgeInsets.all(10),
      height: _animate ? 5 : widget.size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: widget.theme.colorScheme.secondaryContainer,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  widget.workData.workerName(widget.addedWork.workerId),
                  style: widget.theme.textTheme.headlineSmall?.copyWith(fontSize: 20),
                  
                ),
                Column(
                  children: [
                    Text(
                      '${'work: '.tr}${widget.format.format(widget.addedWork.quantity)} ${widget.addedWork.type.name}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: widget.theme.colorScheme.primary),
                    ),
                    Text(
                      'spent: '.tr +
                          widget.format.format(widget.addedWork.amountSpent) +
                          'ryals'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: widget.theme.colorScheme.primary),
                    ),
                    Text(
                      'date: '.tr +
                          DateFormat.Md(widget.local)
                              .format(widget.addedWork.date),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: widget.theme.colorScheme.primary),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                // CustomButton(animate: animate,
                //     firebase: widget.firebase,
                //     message: 'cancle',
                //     ok: false,
                //     notificationList: widget.notificationList,
                //     index: index,
                //     theme: widget.theme),
                ElevatedButton(
                  onPressed: _isloading ? () {} : () => _submit(false),
                  child: Text(
                    'cancle'.tr,
                    style:
                        TextStyle(color: widget.theme.colorScheme.onSecondary),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                // CustomButton(
                //   animate: animate,
                //   firebase: widget.firebase,
                //   notificationList: widget.notificationList,
                //   theme: widget.theme,
                //   index: index,
                //   message: 'ok',
                //   ok: true,
                // ),
                ElevatedButton(
                  onPressed: _isloading ? () {} : () => _submit(true),
                  child: _isloading
                      ? const CircularProgressIndicator()
                      : Text(
                          'ok'.tr,
                          style: TextStyle(
                              color: widget.theme.colorScheme.onSecondary),
                        ),
                ),
                SizedBox(
                  width: widget.size.width * 0.5,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class CustomButton extends StatefulWidget {
//   const CustomButton({
//     super.key,
//     required this.firebase,
//     required this.message,
//     required this.ok,
//     required this.notificationList,
//     required this.index,
//     required this.theme,
//     required this.animate,
//   });
//   final String message;
//   final bool ok;
//   final FirebaseData firebase;
//   final int index;
//   final List<AddedWork> notificationList;
//   final ThemeData theme;
//   final Function animate;

//   @override
//   State<CustomButton> createState() => _CustomButtonState();
// }

// class _CustomButtonState extends State<CustomButton> {
//   bool _isloading = false;

//   Future<void> _submit() async {
//     setState(() {
//       _isloading = true;
//     });

//     await widget.firebase.addWork(
//         widget.ok, widget.notificationList[widget.index], widget.animate);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: _isloading ? () {} : _submit,
//       child: (_isloading && widget.ok)
//           ? const CircularProgressIndicator()
//           : Text(
//               widget.message.tr,
//               style: TextStyle(color: widget.theme.colorScheme.onSecondary),
//             ),
//     );
//   }
// }
