import 'package:duotask/domain/entities/subtask.dart';
import 'package:equatable/equatable.dart';
import 'package:mobx/mobx.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final Observable<TaskStatusType> status;
  final DateTime startDate;
  final DateTime finishDate;
  final List<Subtask> subtasks;

  const Task({
    required this.id,
    required this.title,
    required this.status,
    required this.startDate,
    required this.finishDate,
    required this.subtasks,
  });

  @override
  List<Object> get props => [id, title, status.value, startDate, finishDate];
}

enum TaskStatusType {
  done('done', 'Done'),
  inProgress('inProgress', 'In progress'),
  toDo('toDo', 'To-do');

  final String id;
  final String name;

  const TaskStatusType(this.id, this.name);

  String toJson() => id;

  static List<String> get ids => TaskStatusType.values
      .map(
        (type) => type.id,
      )
      .toList();

  static List<String> get names => TaskStatusType.values
      .map(
        (type) => type.name,
      )
      .toList();

  static TaskStatusType fromJson(String jsonValue) {
    final keys = TaskStatusType.values
        .map(
          (type) => type.id,
        )
        .toList();

    if (keys.contains(jsonValue)) {
      return TaskStatusType.values.firstWhere(
        (enumValue) => enumValue.id == jsonValue,
      );
    } else {
      return TaskStatusType.toDo;
    }
  }
}
