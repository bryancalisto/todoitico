import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  String id;
  String content;
  DateTime created;
  DateTime? limitDate;
  String status;

  Todo({required this.id,  required this.content,  required this.created, this.limitDate, required this.status});

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);
}

