import 'package:flutter/cupertino.dart';
import 'package:todoitico/models/todo.dart';

class TodoNotifier extends InheritedWidget {
  final BaseDatabaseService baseDatabaseService;

  TodoNotifier({this.baseDatabaseService, Widget child}):super(child:child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
