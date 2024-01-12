import 'package:flutter/material.dart';
import 'package:formigas_mvc/formigas_mvc.dart';

import 'package:formigas_mvc_example/src/mvc_example_model.dart';

abstract class ExampleController extends MVController<ExampleModel> {
  ExampleController(super.initialModel);

  void increaseAndShuffleColor();

  void justShuffleColor();
}

class MvcExampleControllerImplementation extends ExampleController {
  MvcExampleControllerImplementation()
      : super(const ExampleModel(color: Colors.blueAccent, value: 0));

  @override
  void increaseAndShuffleColor() => model = model.copyWith(
        value: model.value + 1,
        color: _getRandomColor(),
      );

  @override
  void justShuffleColor() => model = model.copyWith(color: _getRandomColor());

  MaterialColor _getRandomColor() => ([...Colors.primaries]..shuffle()).first;
}
