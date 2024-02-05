import 'package:flutter/material.dart';
import 'package:formigas_mvc_example/tasker/common/services/local_storage_service_implementation.dart';
import 'package:formigas_mvc_example/tasker/features/main/mvc_tasker_controller.dart';
import 'package:formigas_mvc_example/tasker/features/main/mvc_tasker_view.dart';

class TaskerApp extends StatelessWidget {
  const TaskerApp({super.key});

  @override
  Widget build(BuildContext context) {
    ///Init your services
    final localStorageService = LocalStorageServiceImpl();

    return MaterialApp(
      initialRoute: '/home',
      routes: <String, WidgetBuilder>{
        '/home': (_) => MainTaskerScreen(
              controller: TaskerControllerImplementation(
                ///and inject them directly to the controller
                localStorageService,
              ),
            ),
      },
    );
  }
}
