import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:todoitico/models/todo.dart';

abstract class BaseDatabaseService implements ChangeNotifier {
  Future<List<Todo>> get allTodoEntries;

  Future<int> getTodoCount(bool pendingOnly);

  Future<bool> addTodo(Todo entry);

  Future<bool> updateTodo(Todo entry);

  Future<bool> deleteTodo(String id);

  Future<void> checkboxCallback(String id);
}

class TheDatabaseService with ChangeNotifier implements BaseDatabaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference();
  List<Todo> todos = [
    Todo(
        title: 'title',
        id: 'id',
        limitDate: DateTime.now(),
        created: DateTime.now(),
        content: 'content',
        creator: 'creator',
        status: 'P',
        modified: DateTime.now())
  ];

  // TheDatabaseService(){
  //      // addTodo(todos[0]);
  //   allTodoEntries;
  // }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<Todo>> get allTodoEntries async {
    List<Todo> todos = [];
    var receivedTodos = await _dbRef.child('todos').get();
    Map<dynamic, dynamic> values = receivedTodos.value;

    values.forEach((key, values) {
      todos.add(Todo.fromJson(new Map<String, dynamic>.from(values)));
    });

    return todos;
  }

  Future<int> getTodoCount(bool pendingOnly) async {
    int count = 0;
    var receivedTodos = await _dbRef.child('todos').get();
    Map<dynamic, dynamic> values = receivedTodos.value;

    values.forEach((key, values) {
      if ((Todo.fromJson(new Map<String, dynamic>.from(values)).status == 'P' && pendingOnly) || !pendingOnly) {
        count++;
      }
    });

    return count;
  }

  Future<bool> addTodo(Todo entry) async {
    try {
      _dbRef.child('todos').push().set(entry.toJson());
      notifyListeners();
      return true;
    } catch (e) {
      print('Error addTodo: ' + e.toString());
      return false;
    }
  }

  Future<bool> updateTodo(Todo entry) async {
    try {
      var receivedTodos = await _dbRef.child('todos').get();
      notifyListeners();
      return true;
    } catch (e) {
      print('Error updateTodo: ' + e.toString());
      return false;
    }
  }

  Future<bool> deleteTodo(String id) async {
    try {
      print('deleteTodo');
      notifyListeners();
      return true;
    } catch (e) {
      print('Error deleteTodo: ' + e.toString());
      return false;
    }
  }

  Future<void> checkboxCallback(String id) async {
    try {
      print('checkboxCallback');
      notifyListeners();
    } catch (e) {
      print('Error checkboxCallback: ' + e.toString());
    }
  }
}
