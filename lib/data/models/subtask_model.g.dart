// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtask_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubtaskModel _$SubtaskModelFromJson(Map<String, dynamic> json) => SubtaskModel(
      id: json['id'] as String,
      text: json['text'] as String,
      done: json['done'] as bool,
    );

Map<String, dynamic> _$SubtaskModelToJson(SubtaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'done': instance.done,
    };
