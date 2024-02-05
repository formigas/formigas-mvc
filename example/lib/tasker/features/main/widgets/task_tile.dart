import 'package:flutter/material.dart';
import 'package:formigas_mvc_example/tasker/common/models/task.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({
    required Task task,
    super.key,
    ValueChanged<Task>? onChanged,
    ValueChanged<int>? onDelete,
  })  : _task = task,
        _onChanged = onChanged,
        _onDelete = onDelete;

  final Task _task;
  final ValueChanged<Task>? _onChanged;
  final ValueChanged<int>? _onDelete;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  late Task task = widget._task;

  @override
  void didUpdateWidget(covariant TaskTile oldWidget) {
    if (oldWidget._task != widget._task) {
      task = widget._task;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final showDescription =
        task.description != null && task.description!.isNotEmpty;
    return Dismissible(
      key: Key(task.id.toString()),
      onDismissed: widget._onDelete != null
          ? (_) => widget._onDelete?.call(task.id)
          : null,
      background: const ColoredBox(color: Colors.white),
      secondaryBackground: const ColoredBox(
        color: Colors.red,
        child: Row(
          children: [
            Spacer(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Icon(Icons.delete),
            ),
          ],
        ),
      ),
      direction: DismissDirection.endToStart,
      child: CheckboxListTile(
        title: Text(task.title),
        subtitle: showDescription ? Text(task.description!) : null,
        value: task.isCompleted,
        onChanged: (bool? value) {
          setState(() => task = task.copyWith(isCompleted: value!));
          widget._onChanged?.call(task);
        },
      ),
    );
  }
}
