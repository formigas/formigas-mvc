import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formigas_mvc_example/mvc_example_controller.dart';
import 'package:formigas_mvc_example/mvc_example_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: Consumer(
          builder: (context, ref, child) => MvcExampleView(
            controller:
                ref.watch(mvcExampleControllerImplementationProvider.notifier),
            model: ref.watch(
              mvcExampleControllerImplementationProvider,
            ),
          ),
        ),
      ),
    );
  }
}
