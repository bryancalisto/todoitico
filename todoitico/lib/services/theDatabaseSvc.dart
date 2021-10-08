import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:todoitico/models/todo.dart';

abstract class BaseDatabaseService implements ChangeNotifier {
  Future<List<Todo>> get allTodoEntries;

  Future<int> getTodoCount(bool pendingOnly);

  Future<bool> addTodo(Todo todo);

  Future<bool> updateTodo(Todo todo);

  Future<bool> deleteTodo(String id);

  Future<void> checkboxCallback(Todo todo);
}

class TheDatabaseService with ChangeNotifier implements BaseDatabaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference().child(FirebaseAuth.instance.currentUser!.uid);

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<Todo>> get allTodoEntries async {
    List<Todo> todos = [];

    try{
      var receivedTodos = await _dbRef.child('todos').get();
      Map<dynamic, dynamic> values = receivedTodos.value;

      values.forEach((key, values) {
        Todo todo = Todo.fromJson(new Map<String, dynamic>.from(values));
        todo.id = key;
        todos.add(todo);
      });
    }
    catch(e){
      print('Error allTodoEntries: ' + e.toString());
    }

    return todos;
  }

  Future<int> getTodoCount(bool pendingOnly) async {
    int count = 0;

    try{
      var receivedTodos = await _dbRef.child('todos').get();
      Map<dynamic, dynamic> values = receivedTodos.value;

      values.forEach((key, values) {
        if ((Todo.fromJson(new Map<String, dynamic>.from(values)).status == 'P' && pendingOnly) || !pendingOnly) {
          count++;
        }
      });
    }
    catch(e){
      print('Error getTodoCount: ' + e.toString());
    }

    return count;
  }

  Future<bool> addTodo(Todo todo) async {
    try {
      _dbRef.child('todos').push().set(todo.toJson());
      notifyListeners();
      return true;
    } catch (e) {
      print('Error addTodo: ' + e.toString());
      return false;
    }
  }

  Future<bool> updateTodo(Todo todo) async {
    try {
      await _dbRef.child('todos').child(todo.id).update(todo.toJson());
      notifyListeners();
      return true;
    } catch (e) {
      print('Error updateTodo: ' + e.toString());
      return false;
    }
  }

  Future<bool> deleteTodo(String id) async {
    try {
      await _dbRef.child('todos').child(id).remove();
      notifyListeners();
      return true;
    } catch (e) {
      print('Error deleteTodo: ' + e.toString());
      return false;
    }
  }

  Future<void> checkboxCallback(Todo todo) async {
    try {
      await _dbRef.child('todos').child(todo.id).update({'status': todo.status == 'P' ? 'C' : 'P'});
      notifyListeners();
    } catch (e) {
      print('Error checkboxCallback: ' + e.toString());
    }
  }
}
