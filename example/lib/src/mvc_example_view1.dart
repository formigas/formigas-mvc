import 'package:flutter/material.dart';
import 'package:formigas_mvc/formigas_mvc.dart';
import 'package:formigas_mvc_example/src/mvc_example_controller.dart';
import 'package:formigas_mvc_example/src/mvc_example_model.dart';

/// Stateless Widget with MVCBuilder
class MVCBuilderExample extends StatelessWidget {
  const MVCBuilderExample({
    required this.controller,
    super.key,
  });

  final ExampleController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MVCBuilderExample')),
      body: MVCBuilder<ExampleController, ExampleModel>(
        controller: controller,
        builder: (context, controller, model) => Center(
          child: Text('Counter: ${model.value}'),
        ),
      ),
      floatingActionButton: MVCBuilder<ExampleController, ExampleModel>(
        controller: controller,
        builder: (context, controller, model) => FloatingActionButton(
          onPressed: controller.increaseAndShuffleColor,
          backgroundColor: model.color,
          child: const Icon(Icons.plus_one),
        ),
      ),
    );
  }
}
