import 'package:duotask/data/models/subtask_model.dart';
import 'package:duotask/domain/entities/task.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  final String id;
  final String title;
  final String status;
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @JsonKey(name: 'finish_date')
  final DateTime finishDate;
  @JsonKey(
    fromJson: TaskModel.fromSubtaskJsonList,
    toJson: TaskModel.toSubtaskJsonList,
  )
  final List<SubtaskModel> subtasks;

  TaskModel({
    required this.id,
    required this.title,
    required this.status,
    required this.startDate,
    required this.finishDate,
    required this.subtasks,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  factory TaskModel.fromTask(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      status: task.status.value.toJson(),
      startDate: task.startDate,
      finishDate: task.finishDate,
      subtasks: task.subtasks
          .map((subtask) => SubtaskModel.fromSubtask(subtask))
          .toList(),
    );
  }

  Task toTask() {
    return Task(
      id: id,
      title: title,
      status: Observable(TaskStatusType.fromJson(status)),
      startDate: startDate,
      finishDate: finishDate,
      subtasks: subtasks
          .map(
            (subtaskModel) => subtaskModel.toSubtask(),
          )
          .toList(),
    );
  }

  static List<SubtaskModel> fromSubtaskJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SubtaskModel.fromJson(json)).toList();
  }

  static List<dynamic> toSubtaskJsonList(List<SubtaskModel> subtaskModels) {
    return subtaskModels
        .map(
          (model) => model.toJson(),
        )
        .toList();
  }
}
