import 'package:duotask/domain/entities/subtask.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'subtask_model.g.dart';

@JsonSerializable()
class SubtaskModel {
  final String id;
  final String text;
  final bool done;

  SubtaskModel({
    required this.id,
    required this.text,
    required this.done,
  });

  factory SubtaskModel.fromJson(Map<String, dynamic> json) =>
      _$SubtaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubtaskModelToJson(this);

  factory SubtaskModel.fromSubtask(Subtask subtask) {
    return SubtaskModel(
      id: subtask.id,
      text: subtask.text,
      done: subtask.done.value,
    );
  }

  Subtask toSubtask() {
    return Subtask(
      id: id,
      text: text,
      done: Observable(done),
    );
  }
}
