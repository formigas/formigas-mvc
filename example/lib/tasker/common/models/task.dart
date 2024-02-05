import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

part 'task.g.dart';

@freezed
class Task with _$Task {
  factory Task({
    required int id,
    required String title,
    required bool isCompleted,
    String? description,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
