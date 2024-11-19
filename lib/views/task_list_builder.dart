import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskListBuilder extends StatelessWidget {
  final List<Task> tasks;

  const TaskListBuilder({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: UniqueKey(),
          child: Card(
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 1,
            margin: const EdgeInsets.all(5),
            color: const Color.fromARGB(34, 168, 163, 163),
            child: ListTile(
              title: Center(child: Text(tasks[index].description)),
            ),
          ),
        );
      },
    );
  }
}
