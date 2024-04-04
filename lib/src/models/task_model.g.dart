// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'] as int?,
      description: json['task'] as String?,
      status: json['status'] as String?,
      createAt: json['criado_em'] as String?,
      isDone: json['isDone'] as bool? ?? false,
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'task': instance.description,
      'status': instance.status,
      'criado_em': instance.createAt,
      'isDone': instance.isDone,
    };
