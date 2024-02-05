import 'package:flutter/material.dart';
import 'package:formigas_mvc/formigas_mvc.dart';
import 'package:formigas_mvc_example/tasker/common/models/task.dart';
import 'package:formigas_mvc_example/tasker/features/main/mvc_tasker_controller.dart';
import 'package:formigas_mvc_example/tasker/features/main/mvc_tasker_model.dart';
import 'package:formigas_mvc_example/tasker/features/main/widgets/add_task_dialog.dart';
import 'package:formigas_mvc_example/tasker/features/main/widgets/task_tile.dart';

class MainTaskerScreen extends MViewC<TaskerController, TaskerModel> {
  const MainTaskerScreen({required super.controller, super.key});

  @override
  Widget build(BuildContext context, TaskerModel model) => Scaffold(
        appBar: AppBar(title: const Text('Tasker')),
        body: model.tasks.isEmpty
            ? _buildEmptyView()
            : _buildListView(model.tasks),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddTaskDialog(context),
          child: const Icon(Icons.add),
        ),
      );

  Widget _buildEmptyView() {
    return const Center(
      child: Column(
        children: [
          Icon(Icons.hourglass_empty_rounded),
          Text('No task do far'),
        ],
      ),
    );
  }

  Widget _buildListView(List<Task> tasks) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (_, int index) => TaskTile(
        task: tasks[index],
        onChanged: controller.updateTask,
        onDelete: controller.deleteTask,
      ),
    );
  }

  Future<void> _showAddTaskDialog(BuildContext context) async {
    final task = await AddTaskDialog.show(context);
    if (task != null) await controller.addTask(task);
  }
}
