import 'package:formigas_mvc_example/tasker/common/models/task.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mvc_tasker_model.freezed.dart';

@freezed
class TaskerModel with _$TaskerModel {
  const factory TaskerModel({
    required List<Task> tasks,
  }) = _TaskerModel;
}
