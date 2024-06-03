// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      status: json['status'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      finishDate: DateTime.parse(json['finish_date'] as String),
      subtasks: TaskModel.fromSubtaskJsonList(json['subtasks'] as List),
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
      'start_date': instance.startDate.toIso8601String(),
      'finish_date': instance.finishDate.toIso8601String(),
      'subtasks': TaskModel.toSubtaskJsonList(instance.subtasks),
    };
