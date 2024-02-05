import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mvc_example_model.freezed.dart';

@freezed
class ExampleModel with _$ExampleModel {
  const factory ExampleModel({
    required Color color,
    required int value,
  }) = _MvcExampleModel;
}
