import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:statistics_maneger/main_screen/providers/work_data.dart';
import 'package:statistics_maneger/workers_screen/worker_screen/worker_screen.dart';

class WorkersScreen extends StatelessWidget {
  static const route = 'workers_screen';
  const WorkersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workData = Provider.of<WorkData>(context);
    final theme = WorkData.currenTheme;
    final workers = workData.workers;
    return Scaffold(
      appBar: AppBar(
        
        title: Text('workers'.tr),
      ),
      body: ListView.builder(
        itemCount: workers.length,
        itemBuilder: (context, index) {
          final name = workers[index].name;
          final id = workers[index].id;
          return Container(
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(5)),
            child: ListTile(
              onTap: () => Navigator.pushNamed(context, WorkerScreen.route,
                  arguments: [name, id]),
              title: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(name)),
              subtitle: Text('press to view full data'.tr),
              trailing: Hero(
                tag: name,
                child: Icon(
                  Icons.touch_app_outlined,
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
