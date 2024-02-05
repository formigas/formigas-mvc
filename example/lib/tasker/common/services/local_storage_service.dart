import 'package:formigas_mvc_example/tasker/common/models/task.dart';

abstract class LocalStorageService {
  Future<List<Task>> getAllTasks();

  Future<bool> addTask(Task task);

  Future<bool> deleteTask(int taskID);

  Future<bool> updateTask(Task task);
}
