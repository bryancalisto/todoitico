// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      creator: json['creator'] as String,
      created: DateTime.parse(json['created'] as String),
      limitDate: json['limitDate'] == null
          ? null
          : DateTime.parse(json['limitDate'] as String),
      modified: json['modified'] == null
          ? null
          : DateTime.parse(json['modified'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'creator': instance.creator,
      'created': instance.created.toIso8601String(),
      'limitDate': instance.limitDate?.toIso8601String(),
      'modified': instance.modified?.toIso8601String(),
      'status': instance.status,
    };
