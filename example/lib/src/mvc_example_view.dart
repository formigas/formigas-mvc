import 'package:flutter/material.dart';
import 'package:formigas_mvc/formigas_mvc.dart';
import 'package:formigas_mvc_example/src/mvc_example_controller.dart';
import 'package:formigas_mvc_example/src/mvc_example_model.dart';

/// Stateless MVC Widget
class MViewCExample extends MViewC<ExampleController, ExampleModel> {
  const MViewCExample({
    required super.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context, ExampleModel model) => Scaffold(
        appBar: AppBar(title: const Text('MViewCExample')),
        body: Center(child: Text('Counter: ${model.value}')),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.increaseAndShuffleColor,
          backgroundColor: model.color,
          child: const Icon(Icons.plus_one),
        ),
      );
}
