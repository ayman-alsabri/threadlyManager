import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:statistics_maneger/main_screen/home/widgets/todays_work_container.dart';
import 'package:statistics_maneger/main_screen/providers/firebase_data.dart';
import 'package:statistics_maneger/main_screen/providers/work_data.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  Future<void> editType(BuildContext context, String name, int price) async {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 450),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) => Hero(
          tag: name,
          child: FittedBox(child: EditDialog(name: name, price: price)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = WorkData.currenTheme;
    final workData = Provider.of<WorkData>(context);
    final format = WorkData.formatNumbers;
    final size = MediaQuery.sizeOf(context);
    final types = workData.itemTypes;
    return Stack(
      children: [
        SizedBox(
          height: size.height * 0.63 + 32,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Available types'.tr,
                  style: theme.textTheme.headlineSmall!.copyWith(fontSize: 25),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 40),
                  itemCount: types.isEmpty ? 0 : types.length,
                  itemBuilder: (context, index) => Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    //format the number below
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(types[index]!.name,
                                  style: theme.textTheme.headlineMedium),
                              Text('unit price: '.tr +
                                  format.format(types[index]!.price) +
                                  'ryals'.tr),
                            ],
                          ),
                          Hero(
                            tag: types[index]!.name,
                            child: IconButton(
                              onPressed: () => editType(context,
                                  types[index]!.name, types[index]!.price),
                              icon: Icon(Icons.edit,
                                  color: theme.colorScheme.onSecondary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Column(
          mainAxisSize: MainAxisSize.min,
          children: [Expanded(child: SizedBox()), TodaysWorkContainet()],
        )
      ],
    );
  }
}

class EditDialog extends StatefulWidget {
  final String name;
  final int price;
  const EditDialog({required this.name, required this.price, super.key});

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
bool _isloading = false;

  final _textController = TextEditingController();
  late String _newPrice = widget.price.toString();

  late final _firebaseData = Provider.of<FirebaseData>(context, listen: false);

  final _format = WorkData.formatNumbers;
  final _theme = WorkData.currenTheme;

  Future<void> _submit() async {
    setState(() {
      _isloading = true;
    });
    try {
      await _firebaseData.addType(widget.name, int.parse(_newPrice), true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('no internet connection or internet is very slow'.tr),
        ),
      );
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.name),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${'current price'.tr}:${_format.format(widget.price)}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Text(
                  '${'price'.tr}:',
                ),
              ),
              Flexible(
                flex: 1,
                child: TextField(
                  controller: _textController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _theme.colorScheme.secondary),
                  cursorColor: _theme.colorScheme.primary,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: _theme.colorScheme.secondary)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: _theme.colorScheme.onPrimary)),
                    hintStyle: TextStyle(color: _theme.colorScheme.onPrimary),
                  ),
                  onChanged: (value) => setState(() {
                    _newPrice = value.trim();
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed:_isloading?(){}: () => Navigator.pop(context),
          child: Text('cancle'.tr),
        ),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton(
          onPressed:_isloading?(){}: (_textController.text.isNumericOnly &&
                  _textController.text != '0'&&_textController.text!=widget.price.toString())
              ? _submit
              : null,
          child:_isloading? const CircularProgressIndicator(): Text('ok'.tr),
        ),
      ],
    );
  }
}
