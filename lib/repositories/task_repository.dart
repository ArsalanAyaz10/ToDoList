import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../models/task.dart';

class TaskRepository {
  Future<String> _getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _getTaskFile() async {
    final path = await _getLocalPath();
    return File('$path/tasks.json');
  }

  Future<List<Task>> loadTasks() async {
    try {
      final file = await _getTaskFile();
      final contents = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(contents);
      return jsonData.map((json) => Task.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final file = await _getTaskFile();
    final jsonTasks = tasks.map((task) => task.toJson()).toList();

    await file.writeAsString(jsonEncode(jsonTasks));
  }
}
