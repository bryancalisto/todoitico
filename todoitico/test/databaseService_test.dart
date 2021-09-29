// import 'package:flutter_test/flutter_test.dart';
// import 'package:todoitico/models/todo.dart';
//
// void main() {
//   TheDatabaseService dbService;
//
//   final date = DateTime.parse('2021-12-25');
//   const title = 'title';
//   const content = 'content';
//   const creator = 'creator';
//   final limitDate = date.add(Duration(days: 3));
//   const status = 'P';
//
//   group('ADD TODO', () {
//     test('Created todos should be returned', () async {
//       // ARRANGE
//       Todo newTodo =
//           Todo(title: title, content: content, created: date, creator: creator, limitDate: limitDate, status: status);
//
//       // ACT
//       dbService.addTodo(newTodo);
//
//       // ASSERT
//       List<Todo> todos = await dbService.allTodoEntries;
//       expect(todos.first.title, title);
//       expect(todos.first.content, content);
//       expect(todos.first.created, date);
//       expect(todos.first.creator, creator);
//       expect(todos.first.limitDate, limitDate);
//       expect(todos.first.status, status);
//     });
//   });
//
//   group('COUNT TODO', () {
//     test('Todo count (pending only) should return 2 pending todos', () async {
//       // ARRANGE
//       db.delete(db.todos).go();
//
//       Todo newTodo1 =
//           Todo(title: title, content: content, created: date, creator: creator, limitDate: limitDate, status: status);
//       Todo newTodo2 =
//           Todo(title: title, content: content, created: date, creator: creator, limitDate: limitDate, status: status);
//       Todo newTodo3 =
//           Todo(title: title, content: content, created: date, creator: creator, limitDate: limitDate, status: 'F');
//       dbService.addTodo(newTodo1);
//       dbService.addTodo(newTodo2);
//       dbService.addTodo(newTodo3);
//
//       // ACT
//       int count = await dbService.getTodoCount(true);
//
//       // ASSERT
//       expect(count, 2);
//     });
//
//     test('Todo count should return 0 if there are no todos', () async {
//       // ARRANGE
//       db.delete(db.todos).go();
//       // ACT
//       int count = await dbService.getTodoCount(true);
//       // ASSERT
//       expect(count, 0);
//     });
//
//     test('Todo count should return 2 if there is 1 pending todos and 1 fulfilled', () async {
//       // ARRANGE
//       db.delete(db.todos).go();
//       Todo newTodo1 =
//           Todo(title: title, content: content, created: date, creator: creator, limitDate: limitDate, status: 'P');
//       Todo newTodo2 =
//           Todo(title: title, content: content, created: date, creator: creator, limitDate: limitDate, status: 'F');
//       dbService.addTodo(newTodo1);
//       dbService.addTodo(newTodo2);
//
//       // ACT
//       int count = await dbService.getTodoCount(false);
//       // ASSERT
//       expect(count, 2);
//     });
//   });
//
//   group('UPDATE TODO', () {
//     test('Todo gets updated', () async {
//       // ARRANGE
//       db.delete(db.todos).go();
//       final dateUpd = DateTime.parse('2021-12-26');
//       const titleUpd = 'title_';
//       const contentUpd = 'content_';
//       const creatorUpd = 'creator_';
//       final limitDateUpd = date.add(Duration(days: 4));
//
//       Todo newTodo1 =
//           Todo(title: title, content: content, created: date, creator: creator, limitDate: limitDate, status: status);
//
//       Todo newTodo2 =
//           Todo(title: title, content: content, created: date, creator: creator, limitDate: limitDate, status: status);
//
//       dbService.addTodo(newTodo1);
//       dbService.addTodo(newTodo2);
//
//       newTodo1 = (await dbService.allTodoEntries).first;
//
//       Todo updatedTodo1 = newTodo1.copyWith(
//         created: dateUpd,
//         creator: creatorUpd,
//         content: contentUpd,
//         title: titleUpd,
//         limitDate: limitDateUpd,
//       );
//
//       // ACT
//       await dbService.updateTodo(updatedTodo1);
//       final updated = (await dbService.allTodoEntries).first;
//
//       // ASSERT
//       expect(updated, updatedTodo1);
//     });
//   });
//
//   group('DELETE TODO', () {
//     test('Todo gets deleted', () async {
//       // ARRANGE
//       db.delete(db.todos).go();
//       Todo newTodo1 =
//           Todo(title: title, content: content, created: date, creator: creator, limitDate: limitDate, status: status);
//
//       dbService.addTodo(newTodo1);
//       newTodo1 = (await dbService.allTodoEntries).first;
//
//       // ACT
//       await dbService.deleteTodo(newTodo1.id);
//       final nRegs = (await dbService.allTodoEntries).length;
//
//       // ASSERT
//       expect(nRegs, 0);
//     });
//   });
//
//   group('CHECKBOX TOGGLE', () {
//     test('Todo state should be toggled between P and F', () async {
//       // ARRANGE
//       db.delete(db.todos).go();
//       Todo newTodo1 =
//           Todo(title: title, content: content, created: date, creator: creator, limitDate: limitDate, status: status);
//       dbService.addTodo(newTodo1);
//       newTodo1 = (await dbService.allTodoEntries).first;
//
//       // P -> F
//       // ACT
//       await dbService.checkboxCallback(newTodo1.id);
//       Todo updated = (await dbService.allTodoEntries).first;
//
//       // ASSERT
//       expect(updated.status, 'F');
//
//       // F -> P
//       // ACT
//       await dbService.checkboxCallback(updated.id);
//       updated = (await dbService.allTodoEntries).first;
//
//       // ASSERT
//       expect(updated.status, 'P');
//     });
//   });
// }
