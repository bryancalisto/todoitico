import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:todoitico/models/todo.dart';

enum TodoType {
  longTerm,
  daily,
}

abstract class BaseDatabaseService implements ChangeNotifier {
  Future<List<Todo>> getLongTermTodos();

  Future<Map<String, List<Todo>>> getDailyTodos();


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

  Future<List<Todo>> getLongTermTodos() async {
    List<Todo> todos = [];
    DatabaseReference ref = createTodoRef(TodoType.longTerm);

    try {
      var receivedTodos = await ref.get();
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

  Future<Map<String, List<Todo>>> getDailyTodos() async {
    List<Todo> todos = [];
    DatabaseReference ref = createTodoRef(TodoType.daily);

    try {
      var receivedTodos = await ref.get();
      Map<dynamic, dynamic> values = receivedTodos.value;

      values.forEach((key, values) {
        Todo todo = Todo.fromJson(new Map<String, dynamic>.from(values));
        todo.id = key;
        todos.add(todo);
      });
    } catch (e) {
      print('Error getDailyTodos: ' + e.toString());
    }

    return {};
  }

  Future<bool> addTodo(Todo todo, TodoType type) async {
    DatabaseReference ref = createTodoRef(type);

    if (type == TodoType.daily) {
      ref = ref.child(DateTime.now().toString());
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
      ref = ref.child(todo.created.toIso8601String());
    }

    try {
      await _dbRef.child('todos').child(todo.id).update(todo.toJson());
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
      ref = ref.child(todo.created.toIso8601String());
    }

    try {
      await _dbRef.child('todos').child(todo.id).remove();
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
      ref = ref.child(todo.created.toIso8601String());
    }

    try {
      await ref.child(todo.id).update({'status': todo.status == 'P' ? 'C' : 'P'});
      notifyListeners();
    } catch (e) {
      print('Error checkboxCallback: ' + e.toString());
    }
  }
}
