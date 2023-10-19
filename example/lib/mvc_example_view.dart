import 'package:flutter/material.dart';
import 'package:formigas_mvc/formigas_mvc.dart';
import 'package:formigas_mvc_example/mvc_example_model.dart';

class MvcExampleView extends MvcView<MvcExampleController, MvcExampleModel> {
  const MvcExampleView({
    super.key,
    required super.controller,
    required super.model,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('formigas MVC example app'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.increaseAndShuffleColor,
          backgroundColor: model.color,
          child: const Icon(Icons.plus_one),
        ),
        body: Center(
          child: Text('Counter: ${model.value}'),
        ),
      );
}

abstract class MvcExampleController implements MvcController {
  void increaseAndShuffleColor();
}
