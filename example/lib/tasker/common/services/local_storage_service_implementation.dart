import 'dart:async';
import 'dart:convert';

import 'package:formigas_mvc_example/tasker/common/models/task.dart';
import 'package:formigas_mvc_example/tasker/common/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageServiceImpl implements LocalStorageService {
  LocalStorageServiceImpl() {
    SharedPreferences.getInstance()
        .then(_prefs.complete)
        .onError(_prefs.completeError);
  }

  final _prefs = Completer<SharedPreferences>();
  static const _listKey = 'tasks';

  @override
  Future<List<Task>> getAllTasks() async {
    return ((await _prefs.future).getStringList(_listKey) ?? [])
        .map((task) => Task.fromJson(jsonDecode(task) as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<bool> addTask(Task task) async {
    final tasks = await getAllTasks();
    tasks.add(task);
    return _updateTasks(tasks);
  }

  @override
  Future<bool> deleteTask(int taskID) async {
    final tasks = await getAllTasks();
    tasks.removeWhere((element) => element.id == taskID);
    return _updateTasks(tasks);
  }

  @override
  Future<bool> updateTask(Task task) async {
    final oldTasks = await getAllTasks();
    final updated = oldTasks
        .map((element) => element.id == task.id ? task : element)
        .toList();
    return _updateTasks(updated);
  }

  Future<bool> _updateTasks(List<Task> tasks) async {
    return (await _prefs.future).setStringList(
      _listKey,
      tasks.map((task) => jsonEncode(task.toJson())).toList(),
    );
  }
}
