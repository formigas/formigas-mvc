import 'package:flutter/material.dart';
import 'package:formigas_mvc_example/mvc_example_model.dart';
import 'package:formigas_mvc_example/mvc_example_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mvc_example_controller.g.dart';

@riverpod
class MvcExampleControllerImplementation
    extends _$MvcExampleControllerImplementation
    implements MvcExampleController {
  @override
  MvcExampleModel build() => MvcExampleModel(
        color: _getRandomColor(),
        value: 0,
      );

  @override
  void trackPageView({required String pageName}) {}

  @override
  void increaseAndShuffleColor() => state = state.copyWith(
        value: state.value + 1,
        color: _getRandomColor(),
      );

  MaterialColor _getRandomColor() => ([...Colors.primaries]..shuffle()).first;
}
