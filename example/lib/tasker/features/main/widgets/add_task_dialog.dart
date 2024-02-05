import 'package:flutter/material.dart';
import 'package:formigas_mvc_example/tasker/common/models/task.dart';

class AddTaskDialog extends StatelessWidget {
  AddTaskDialog({super.key});

  static Future<Task?> show(BuildContext context) {
    return showDialog<Task>(
      context: context,
      builder: (context) => AddTaskDialog(),
    );
  }

  final _titleKey = GlobalKey<FormFieldState<String>>();
  final _descriptionKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            key: _titleKey,
            decoration: const InputDecoration(hintText: 'Task title'),
            validator: (value) => value.whenEmpty('Title is required'),
          ),
          TextFormField(
            key: _descriptionKey,
            decoration: const InputDecoration(hintText: 'Task description'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => _onAddTask(context),
          child: const Text('Add task'),
        ),
      ],
    );
  }

  void _onAddTask(BuildContext context) {
    if (_titleKey.currentState!.validate()) {
      final task = Task(
        id: DateTime.now().millisecondsSinceEpoch,
        title: _titleKey.currentState!.value!,
        description: _descriptionKey.currentState!.value,
        isCompleted: false,
      );
      Navigator.pop(context, task);
    }
  }
}

extension on String? {
  String? whenEmpty(String message) {
    return (this == null || this!.isEmpty) ? message : null;
  }
}
