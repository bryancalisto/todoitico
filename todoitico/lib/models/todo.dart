import 'package:moor/moor.dart';
import 'package:flutter/foundation.dart';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'todo.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(max: 32)();

  TextColumn get content => text().withLength(max: 256)();

  TextColumn get creator => text().withLength(max: 50)();

  DateTimeColumn get created => dateTime().withDefault(currentDate)();

  DateTimeColumn get limitDate => dateTime().nullable()();

  DateTimeColumn get modified => dateTime().nullable()();

  TextColumn get status => text().withLength(min: 1, max: 1)();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Todos])
class TheDatabase extends _$TheDatabase {
  TheDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition
  @override
  int get schemaVersion => 2;
}

class TheDatabaseService with ChangeNotifier {
  final TheDatabase db = TheDatabase();

  Future<List<Todo>> get allTodoEntries => db.select(db.todos).get();

  Future<int> getTodoCount() async {
    Expression countExp = db.todos.id.count();
    final query = db.selectOnly(db.todos)..addColumns([countExp]);
    return await query.map((row) => row.read(countExp)).getSingle();
  }

  Future<bool> addTodo(TodosCompanion entry) async {
    try {
      db.into(db.todos).insert(entry);
      return true;
    } catch (e) {
      print('Error addTodo: ' + e);
      return false;
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      db.delete(db.todos)..where((reg) => reg.id.equals(id));
      return true;
    } catch (e) {
      print('Error deleteTodo: ' + e);
      return false;
    }
  }

  void checkboxCallback(int id) async {
    try {
      Todo todo = await (db.select(db.todos)..where((reg) => reg.id.equals(id))).getSingle();
      (db.update(db.todos)..where((reg) => reg.id.equals(id)))
          .write(TodosCompanion(status: Value(todo.status == 'F' ? 'P' : 'F'))); // Fulfilled or pending
      notifyListeners();
    } catch (e) {
      print('Error checkboxCallback: ' + e);
    }
  }

  void closeDB() {
    db.close();
  }
}
