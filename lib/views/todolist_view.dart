import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import 'task_list_builder.dart';

class TodolistView extends StatefulWidget {
  final Function(ThemeMode) toggleTheme;

  const TodolistView({super.key, required this.toggleTheme});

  @override
  State<TodolistView> createState() => _TodolistViewState();
}

class _TodolistViewState extends State<TodolistView> {
  final TaskController _taskController = TaskController();
  String newTask = '';

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    await _taskController.loadTasks();
    setState(() {});
  }

  void _addTask(String description) async {
    await _taskController.addTask(description);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("To Do List")),
        elevation: 5,
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: const Icon(Icons.sunny),
            onPressed: () => widget.toggleTheme(ThemeMode.light),
          ),
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () => widget.toggleTheme(ThemeMode.dark),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Add Task'),
                  content: TextField(
                    onChanged: (String value) {
                      setState(() {
                        newTask = value;
                      });
                    },
                    decoration: const InputDecoration(hintText: 'Enter task'),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        _addTask(newTask);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                );
              });
        },
      ),
      body: TaskListBuilder(tasks: _taskController.tasks),
    );
  }
}
