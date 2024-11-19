import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;
  List<String> items = [];

  void toggleTheme(ThemeMode mode) {
    setState(() {
      themeMode = mode;
    });
  }

  void addItem(String item) {
    setState(() {
      items.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      themeMode: themeMode,
      home: Todolist(toggleTheme: toggleTheme, addItem: addItem, items: items),
    );
  }
}

class Todolist extends StatefulWidget {
  final Function(ThemeMode) toggleTheme;
  final Function(String) addItem;
  final List<String> items;

  const Todolist(
      {super.key,
      required this.toggleTheme,
      required this.addItem,
      required this.items});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  String newTask = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("To Do List"),
        ),
        elevation: 5,
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: const Icon(Icons.sunny),
            onPressed: () {
              widget.toggleTheme(ThemeMode.light);
            },
          ),
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () {
              widget.toggleTheme(ThemeMode.dark);
            },
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
                        String? newItem = newTask;
                        widget.addItem(newItem);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add'),
                    ),
                  ],
                );
              });
        },
      ),
      body: TaskListBuilder(items: widget.items),
    );
  }
}

class TaskListBuilder extends StatelessWidget {
  final List<String> items;

  const TaskListBuilder({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: UniqueKey(),
          child: Card(
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 1,
            margin: const EdgeInsets.all(5),
            color: const Color.fromARGB(34, 168, 163, 163),
            child: ListTile(
              autofocus: true,
              title: Center(child: Text(items[index])),
            ),
          ),
        );
      },
    );
  }
}
