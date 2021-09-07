import 'package:flutter_test/flutter_test.dart';
import 'package:moor/ffi.dart';
import 'package:todoitico/models/todo.dart';

void main() {
  TheDatabase db;
  TheDatabaseService dbService;

  setUp(() {
    db = TheDatabase(VmDatabase.memory());
    dbService = TheDatabaseService(db);
  });

  tearDown(() {
    dbService.closeDB();
  });

  group('ADD TODO', () {
    test('Created todos should be returned', () async {
      // ARRANGE
      final date = DateTime.parse('2021-12-25');
      const title = 'title';
      const content = 'content';
      const creator = 'creator';
      final limitDate = date.add(Duration(days: 3));
      const status = 'P';

      Todo newTodo =
          Todo(title: title, content: content, created: date, creator: creator, limitDate: limitDate, status: status);

      // ACT
      dbService.addTodo(newTodo.toCompanion(true));

      // ASSERT
      List<Todo> todos = await dbService.allTodoEntries;
      expect(todos.first.title, title);
      expect(todos.first.content, content);
      expect(todos.first.created, date);
      expect(todos.first.creator, creator);
      expect(todos.first.limitDate, limitDate);
      expect(todos.first.status, status);
    });
  });

  group('COUNT TODO', () {
    test('Todo count (pending only) should return 2 pending todos', () async {
      // ARRANGE
      db.delete(db.todos).go();
      final date = DateTime.parse('2021-12-25');
      const title = 'title';
      const content = 'content';
      const creator = 'creator';
      final limitDate = date.add(Duration(days: 3));
      const status = 'P';

      Todo newTodo1 =
          Todo(title: title, content: content, created: date, creator: creator, limitDate: limitDate, status: status);

      Todo newTodo2 =
          Todo(title: title, content: content, created: date, creator: creator, limitDate: limitDate, status: status);

      Todo newTodo3 =
          Todo(title: title, content: content, created: date, creator: creator, limitDate: limitDate, status: 'F');

      // ACT
      dbService.addTodo(newTodo1.toCompanion(true));
      dbService.addTodo(newTodo2.toCompanion(true));
      dbService.addTodo(newTodo3.toCompanion(true));
      int count = await dbService.getTodoCount(true);

      // ASSERT
      expect(count, 2);
    });

    test('Todo count should return 0 if there are no todos', () async {
      // ARRANGE
      db.delete(db.todos).go();
      // ACT
      int count = await dbService.getTodoCount(true);
      // ASSERT
      expect(count, 0);
    });

    test('Todo count should return 2 if there is 1 pending todos and 1 fulfilled', () async {
      // ARRANGE
      db.delete(db.todos).go();
      final date = DateTime.parse('2021-12-25');
      const title = 'title';
      const content = 'content';
      const creator = 'creator';
      final limitDate = date.add(Duration(days: 3));

      Todo newTodo1 =
          Todo(title: title, content: content, created: date, creator: creator, limitDate: limitDate, status: 'P');

      Todo newTodo2 =
          Todo(title: title, content: content, created: date, creator: creator, limitDate: limitDate, status: 'F');

      // ACT
      dbService.addTodo(newTodo1.toCompanion(true));
      dbService.addTodo(newTodo2.toCompanion(true));
      int count = await dbService.getTodoCount(false);
      // ASSERT
      expect(count, 2);
    });
  });

  group('UPDATE TODO', () {});

  group('DELETE TODO', () {});

  group('CHECKBOX TOGGLE', () {});
}
