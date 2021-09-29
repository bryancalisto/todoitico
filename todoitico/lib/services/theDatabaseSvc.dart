import 'package:flutter/foundation.dart';
import 'package:todoitico/models/todo.dart';

abstract class BaseDatabaseService implements ChangeNotifier {
  Future<List<Todo>> get allTodoEntries;

  Future<int> getTodoCount(bool pendingOnly);

  Future<bool> addTodo(Todo entry);

  Future<bool> updateTodo(Todo entry);

  Future<bool> deleteTodo(int id);

  Future<void> checkboxCallback(int id);
}

class TheDatabaseService with ChangeNotifier implements BaseDatabaseService {
  @override
  void dispose() {
    super.dispose();
  }

  Future<List<Todo>> get allTodoEntries {
    return Future.value([]);
  }

  Future<int> getTodoCount(bool pendingOnly) async {
    if (pendingOnly) {
      return Future.value(0);
    } else {
      return Future.value(1);
    }
  }

  Future<bool> addTodo(Todo entry) async {
    try {
      print('addTodo');
      notifyListeners();
      return true;
    } catch (e) {
      print('Error addTodo: ' + e);
      return false;
    }
  }

  Future<bool> updateTodo(Todo entry) async {
    try {
      print('updateTodo');
      notifyListeners();
      return true;
    } catch (e) {
      print('Error updateTodo: ' + e);
      return false;
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      print('deleteTodo');
      notifyListeners();
      return true;
    } catch (e) {
      print('Error deleteTodo: ' + e);
      return false;
    }
  }

  Future<void> checkboxCallback(int id) async {
    try {
      print('checkboxCallback');
      notifyListeners();
    } catch (e) {
      print('Error checkboxCallback: ' + e);
    }
  }
}
