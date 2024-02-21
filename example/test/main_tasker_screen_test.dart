import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formigas_mvc_example/tasker/common/models/task.dart';
import 'package:formigas_mvc_example/tasker/features/main/mvc_tasker_controller.dart';
import 'package:formigas_mvc_example/tasker/features/main/mvc_tasker_model.dart';
import 'package:formigas_mvc_example/tasker/features/main/mvc_tasker_view.dart';
import 'package:formigas_mvc_example/tasker/features/main/widgets/add_task_dialog.dart';
import 'package:formigas_mvc_example/tasker/features/main/widgets/task_tile.dart';

class TaskerControllerMock extends TaskerController {
  TaskerControllerMock(List<Task> tasks) : super(TaskerModel(tasks: tasks)) {}

  @override
  Future<void> addTask(Task task) async {
    final tasks = [...model.tasks, task];
    model = model.copyWith(tasks: tasks);
  }

  @override
  Future<void> deleteTask(int taskID) async {
    final tasks = [...model.tasks]
      ..removeWhere((element) => element.id == taskID);
    model = model.copyWith(tasks: tasks);
  }

  @override
  Future<void> updateTask(Task task) async {
    final tasks = [...model.tasks];
    final index = tasks.indexWhere((element) => element.id == task.id);
    tasks[index] = task;
    model = model.copyWith(tasks: tasks);
  }
}

void main() {
  Future<void> pumpWidget(
    WidgetTester tester, {
    List<Task> tasks = const [],
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MainTaskerScreen(
          controller: TaskerControllerMock(tasks),
        ),
      ),
    );
  }

  group('TaskerScreen', () {
    testWidgets(
      'builds EmptyView',
      (WidgetTester tester) async {
        // Build the MainTaskerScreen widget
        await pumpWidget(tester);

        // Verify the Text widget displays 'No task so far'
        expect(find.text('No task so far'), findsOneWidget);
        expect(find.byType(TaskTile), findsNothing);
      },
    );

    testWidgets(
      'builds ListView and shows exact one item',
      (WidgetTester tester) async {
        final tasks = [Task(id: 1, title: 'Task 1', isCompleted: false)];
        // Build the MainTaskerScreen widget
        await pumpWidget(tester, tasks: tasks);

        // Verify the TaskTile widgets display the correct task descriptions
        expect(find.text('Task 1'), findsOneWidget);
        expect(find.text('Description 1'), findsNothing);
      },
    );

    testWidgets(
      'builds ListView and shows item description',
      (WidgetTester tester) async {
        final tasks = [
          Task(
            id: 1,
            title: 'Task 1',
            description: 'Description 1',
            isCompleted: false,
          ),
        ];
        // Build the MainTaskerScreen widget
        await pumpWidget(tester, tasks: tasks);

        // Verify the TaskTile widgets display the correct task descriptions
        expect(find.text('Task 1'), findsOneWidget);
        expect(find.text('Description 1'), findsOneWidget);
      },
    );

    testWidgets(
      'builds ListView and shows multiple items',
      (WidgetTester tester) async {
        final tasks = [
          Task(id: 1, title: 'Task 1', isCompleted: false),
          Task(id: 1, title: 'Task 2', isCompleted: false),
        ];
        // Build the MainTaskerScreen widget
        await pumpWidget(tester, tasks: tasks);

        expect(find.byType(TaskTile), findsNWidgets(2));

        // Verify the TaskTile widgets display the correct task descriptions
        expect(find.text('Task 1'), findsOneWidget);
        expect(find.text('Task 2'), findsOneWidget);
      },
    );

    testWidgets(
      'builds ListView and shows correct completion statuses',
      (WidgetTester tester) async {
        final tasks = [
          Task(id: 1, title: 'Task 1', isCompleted: false),
          Task(id: 2, title: 'Task 2', isCompleted: true),
        ];
        // Build the MainTaskerScreen widget
        await pumpWidget(tester, tasks: tasks);

        expect(find.byType(TaskTile), findsNWidgets(2));

        // Verify the TaskTile widgets show the correct completion status
        for (final element in find.byType(CheckboxListTile).evaluate()) {
          final taskTile = element.widget as CheckboxListTile;
          if (taskTile.key.toString() == const ValueKey(1).toString()) {
            expect(taskTile.value, false);
          } else {
            expect(taskTile.value, true);
          }
        }
      },
    );
  });

  group('TaskerScreen', () {
    testWidgets('add new Task', (tester) async {
      await pumpWidget(tester);

      // Verify the TaskTile widgets display the correct task descriptions
      expect(find.text('No task so far'), findsOneWidget);
      expect(find.byType(TaskTile), findsNothing);

      // Tap the floating action button
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Verify the AddTaskDialog is shown
      expect(find.byType(AddTaskDialog), findsOneWidget);

      // Enter the task title and description
      await tester.enterText(
        find.byType(TextFormField).first,
        'Task 1',
      );
      await tester.enterText(
        find.byType(TextFormField).last,
        'Description 1',
      );

      // Tap the add button
      await tester.tap(find.text('Add task'));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 1));

      // Verify the TaskTile widgets display the correct task descriptions
      expect(find.text('Task 1'), findsOneWidget);
      expect(find.text('Description 1'), findsOneWidget);
    });

    testWidgets('removes Task', (tester) async {
      final tasks = [
        Task(id: 1, title: 'Task 1', isCompleted: false),
        Task(id: 2, title: 'Task 2', isCompleted: false),
      ];
      await pumpWidget(tester, tasks: tasks);

      // Verify the TaskTile widgets display the correct task descriptions
      expect(find.text('Task 1'), findsOneWidget);
      expect(find.text('Task 2'), findsOneWidget);

      await tester.drag(find.text('Task 1'), const Offset(-400, 0));
      await tester.pumpAndSettle();

      // Verify the TaskTile widgets display the correct task descriptions
      expect(find.text('Task 1'), findsNothing);
      expect(find.text('Task 2'), findsOneWidget);
    });

    testWidgets('updates Task', (widgetTester) async {
      final tasks = [
        Task(id: 1, title: 'Task 1', isCompleted: false),
        Task(id: 2, title: 'Task 2', isCompleted: false),
      ];
      await pumpWidget(widgetTester, tasks: tasks);

      var results = find.byType(CheckboxListTile).evaluate().map((element) {
        final taskTile = element.widget as CheckboxListTile;
        return taskTile.value;
      });
      expect(results, [false, false]);

      // Tap the TaskTile to open the UpdateTaskDialog
      await widgetTester.tap(find.text('Task 1'));
      await widgetTester.pumpAndSettle();

      results = find.byType(CheckboxListTile).evaluate().map((element) {
        final taskTile = element.widget as CheckboxListTile;
        return taskTile.value;
      });
      expect(results, [true, false]);
    });
  });
}
