// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      id: json['id'] as String,
      content: json['content'] as String,
      created: DateTime.parse(json['created'] as String),
      limitDate: json['limitDate'] == null
          ? null
          : DateTime.parse(json['limitDate'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'created': instance.created.toIso8601String(),
      'limitDate': instance.limitDate?.toIso8601String(),
      'status': instance.status,
    };
