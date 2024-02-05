import 'package:formigas_mvc/formigas_mvc.dart';
import 'package:formigas_mvc_example/tasker/common/models/task.dart';
import 'package:formigas_mvc_example/tasker/common/services/local_storage_service.dart';
import 'package:formigas_mvc_example/tasker/features/main/mvc_tasker_model.dart';

abstract class TaskerController extends MVController<TaskerModel> {
  TaskerController(super.initialModel);

  Future<void> addTask(Task task);

  Future<void> updateTask(Task task);

  Future<void> deleteTask(int taskID);
}

class TaskerControllerImplementation extends TaskerController {
  TaskerControllerImplementation(this._localStorageService)
      : super(const TaskerModel(tasks: [])) {
    _updateTaskList();
  }

  final LocalStorageService _localStorageService;

  @override
  Future<void> addTask(Task task) async {
    await _localStorageService.addTask(task);
    await _updateTaskList();
  }

  @override
  Future<void> updateTask(Task task) async {
    await _localStorageService.updateTask(task);
    await _updateTaskList();
  }

  @override
  Future<void> deleteTask(int taskID) async {
    await _localStorageService.deleteTask(taskID);
    await _updateTaskList();
  }

  Future<void> _updateTaskList() async {
    final tasks = await _localStorageService.getAllTasks();
    model = model.copyWith(tasks: tasks);
  }
}
