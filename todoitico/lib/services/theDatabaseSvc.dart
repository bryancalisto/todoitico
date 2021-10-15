import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:todoitico/models/todo.dart';

enum TodoType {
  longTerm,
  daily,
}

abstract class BaseDatabaseService implements ChangeNotifier {
  Stream<List<Todo>> suscribeForLongTermTodos();

  Stream<List<Todo>> suscribeForDailyTodos(DateTime date);

  Future<List<Todo>> getLongTermTodos();

  Future<List<Todo>> getDailyTodos(DateTime date);

  Future<bool> addTodo(Todo todo, TodoType type);

  Future<bool> updateTodo(Todo todo, TodoType todoType);

  Future<bool> deleteTodo(Todo todo, TodoType todoType);

  Future<void> checkboxCallback(Todo todo, TodoType todoType);
}

class TheDatabaseService with ChangeNotifier implements BaseDatabaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference().child(FirebaseAuth.instance.currentUser!.uid);

  @override
  void dispose() {
    super.dispose();
  }

  DatabaseReference createTodoRef(TodoType type) {
    DatabaseReference ref = _dbRef.child('todos');

    if (type == TodoType.longTerm) {
      ref = ref.child('longTerm');
    } else {
      ref = ref.child('daily');
    }

    return ref;
  }

  String createDateKey(DateTime date) {
    return DateFormat('yyyyMMdd').format(date);
  }

  Stream<List<Todo>> suscribeForLongTermTodos() async*{
    DatabaseReference ref = createTodoRef(TodoType.longTerm);

    try {
      await for(final event in ref.onValue){
        List<Todo> todos = [];

        if (event.snapshot.value != null) {
          final values = Map<String, dynamic>.from(event.snapshot.value);

          values.forEach((key, values) {
            Todo todo = Todo.fromJson(new Map<String, dynamic>.from(values));
            todo.id = key;
            todos.add(todo);
          });
        }

        yield todos;
      }
    } catch (e) {
      print('Error suscribeForTodos: ' + e.toString());
    }
  }

  Stream<List<Todo>> suscribeForDailyTodos(DateTime date) async*{
    DatabaseReference ref = createTodoRef(TodoType.daily);

    try {
      await for(final event in ref.child(createDateKey(date)).onValue){
        List<Todo> todos = [];
        if (event.snapshot.value != null) {
          final values = Map<String, dynamic>.from(event.snapshot.value);
          values.forEach((key, values) {
            Todo todo = Todo.fromJson(new Map<String, dynamic>.from(values));
            todo.id = key;
            todos.add(todo);
          });
        }
        yield todos;
      }

    } catch (e) {
      print('Error suscribeForTodos: ' + e.toString());
    }
  }

  Future<List<Todo>> getLongTermTodos() async {
    List<Todo> todos = [];
    DatabaseReference ref = createTodoRef(TodoType.longTerm);

    try {
      var receivedTodos = await ref.get();

      if (receivedTodos.value == null) {
        return todos;
      }

      Map<dynamic, dynamic> values = receivedTodos.value;

      values.forEach((key, values) {
        Todo todo = Todo.fromJson(new Map<String, dynamic>.from(values));
        todo.id = key;
        todos.add(todo);
      });
    } catch (e) {
      print('Error getLongTermTodos: ' + e.toString());
    }

    return todos;
  }

  Future<List<Todo>> getDailyTodos(DateTime date) async {
    List<Todo> todos = [];
    DatabaseReference ref = createTodoRef(TodoType.daily);

    try {
      var receivedTodos = await ref.child(createDateKey(date)).get();

      if (receivedTodos.value == null) {
        return todos;
      }

      Map<dynamic, dynamic> values = receivedTodos.value;

      values.forEach((key, values) {
        Todo todo = Todo.fromJson(new Map<String, dynamic>.from(values));
        todo.id = key;
        todos.add(todo);
      });
    } catch (e) {
      print('Error getDailyTodos: ' + e.toString());
    }

    return todos;
  }

  Future<bool> addTodo(Todo todo, TodoType type) async {
    DatabaseReference ref = createTodoRef(type);

    // Database key is the todo creation day
    if (type == TodoType.daily) {
      ref = ref.child(createDateKey(todo.created));
    }

    try {
      ref.push().set(todo.toJson());
      notifyListeners();
      return true;
    } catch (e) {
      print('Error addTodo: ' + e.toString());
      return false;
    }
  }

  Future<bool> updateTodo(Todo todo, TodoType type) async {
    DatabaseReference ref = createTodoRef(type);

    if (type == TodoType.daily) {
      ref = ref.child(createDateKey(todo.created));
    }

    try {
      await ref.child(todo.id).update(todo.toJson());
      notifyListeners();
      return true;
    } catch (e) {
      print('Error updateTodo: ' + e.toString());
      return false;
    }
  }

  Future<bool> deleteTodo(Todo todo, TodoType type) async {
    DatabaseReference ref = createTodoRef(type);

    if (type == TodoType.daily) {
      ref = ref.child(createDateKey(todo.created));
    }

    try {
      await ref.child(todo.id).remove();
      notifyListeners();
      return true;
    } catch (e) {
      print('Error deleteTodo: ' + e.toString());
      return false;
    }
  }

  Future<void> checkboxCallback(Todo todo, TodoType type) async {
    DatabaseReference ref = createTodoRef(type);

    if (type == TodoType.daily) {
      ref = ref.child(createDateKey(todo.created));
    }

    try {
      await ref.child(todo.id).update({'status': todo.status == 'P' ? 'C' : 'P'});
      notifyListeners();
    } catch (e) {
      print('Error checkboxCallback: ' + e.toString());
    }
  }
}
