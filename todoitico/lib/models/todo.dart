import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo {
  String id;
  String title;
  String content;
  String creator;
  DateTime created;
  DateTime? limitDate;
  DateTime? modified;
  String status;

  Todo({required this.id, required this.title, required this.content, required this.creator, required this.created, this.limitDate, this.modified,required this.status});

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);
}

