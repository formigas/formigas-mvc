import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mvc_example_model.freezed.dart';

@freezed
class MvcExampleModel with _$MvcExampleModel {
  const factory MvcExampleModel({
    required final Color color,
    required final int value,
  }) = _MvcExampleModel;
}
