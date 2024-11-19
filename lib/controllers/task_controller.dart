import '../models/task.dart';
import '../repositories/task_repository.dart';

class TaskController {
  final TaskRepository _taskRepository = TaskRepository();

  List<Task> tasks = [];

  Future<void> loadTasks() async {
    tasks = await _taskRepository.loadTasks();
  }

  Future<void> addTask(String description) async {
    final newTask =
        Task(id: DateTime.now().toString(), description: description);
    tasks.add(newTask);
    await _taskRepository.saveTasks(tasks);
  }
}
