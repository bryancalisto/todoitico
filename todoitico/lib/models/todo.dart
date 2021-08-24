import 'package:moor/moor.dart';

// These imports are only needed to open the database
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
}

// class AppDb extends _$AppDb {
//   AppDb() : super(_openConnection());
//
//   @override
//   int get schemaVersion => 1;
// }

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Todos])
class TheDatabase extends _$TheDatabase {
  // we tell the database where to store the data with this constructor
  TheDatabase() : super(_openConnection());

  Future<List<Todo>> get allTodoEntries => select(todos).get();
  Future<int> addTodo(TodosCompanion entry){
    return into(todos).insert(entry);
  }

  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 1;
}
