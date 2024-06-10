import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:statistics_maneger/main_screen/providers/firebase_data.dart';
import 'package:statistics_maneger/main_screen/providers/work_data.dart';

class AddSheet extends StatefulWidget {
  const AddSheet({super.key});

  @override
  State<AddSheet> createState() => _AddSheetState();
}

class _AddSheetState extends State<AddSheet> {
  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    _textController2.dispose();
  }

  final _textController = TextEditingController();
  final _textController2 = TextEditingController();

  final _theme = WorkData.currenTheme;
  late final _firebase = Provider.of<FirebaseData>(context, listen: false);
  late final _typesList =
      Provider.of<WorkData>(context, listen: false).itemTypes;

  bool _isloading = false;
  final _inputData = {
    'typeName': '',
    'price': '',
  };

  Future<void> _submit() async {
    final contin = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title:  Text('do you want to add:'.tr),
        content: Text(
            '${'type'.tr}: ${_inputData['typeName']!}\n${'price'.tr}: ${_inputData['price']!}'),
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

    if (contin!=true) return;
    setState(() {
      _isloading = true;
    });

    String message = 'could not add. please try again';

    try {
      for (var element in _typesList) {
        if (element!.name == _inputData['typeName']) {
          throw Exception('this type already exists');
        }
      }
      await _firebase.addType(
          _inputData['typeName']!, int.parse(_inputData['price']!),false);
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (e.toString() == 'Exception: this type already exists') {
        message = 'this type already exists';
      }

      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message.tr),
      ));
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
                          'type name'.tr,
                          style: TextStyle(
                              color: _theme.colorScheme.secondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        )),
                    Flexible(
                      flex: 1,
                      child: TextField(
                        controller: _textController,
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.center,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(color: _theme.colorScheme.secondary),
                        cursorColor: _theme.colorScheme.primary,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: _theme.colorScheme.secondary)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: _theme.colorScheme.onPrimary)),
                          hintStyle:
                              TextStyle(color: _theme.colorScheme.onPrimary),
                        ),
                        onSubmitted: (value) =>
                            _inputData['typeName'] = value.trim(),
                        onTapOutside: (event) => _inputData['typeName'] =
                            _textController.text.trim(),
                        // autofillHints: const <String>[
                        //   'شميز',
                        //   'بنطلون',
                        //   'ثوب',
                        //   'يلق',
                        // ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Text(
                        'price'.tr,
                        style: TextStyle(
                            color: _theme.colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: TextField(
                        controller: _textController2,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: _theme.colorScheme.secondary),
                        cursorColor: _theme.colorScheme.primary,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: _theme.colorScheme.secondary)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: _theme.colorScheme.onPrimary)),
                          hintStyle:
                              TextStyle(color: _theme.colorScheme.onPrimary),
                        ),
                        onSubmitted: (value) => setState(() {
                          _inputData['price'] = value.trim();
                        }),
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
                        : ((_textController.text.isEmpty ||
                                    _textController2.text.isEmpty) ||
                                (_textController.text.length < 3 ||
                                    !_textController2.text.isNumericOnly ||
                                    _textController2.text == '0'))
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
