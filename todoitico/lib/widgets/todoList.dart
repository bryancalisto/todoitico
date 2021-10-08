import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/models/todo.dart';
import 'package:todoitico/services/theDatabaseSvc.dart';
import 'package:todoitico/widgets/todoTile.dart';

// class LongTermTodoList extends StatelessWidget {
//   final List<Todo> todos;
//
//   const LongTermTodoList({required this.todos});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BaseDatabaseService>(
//       builder: (context, data, child) {
//         return ListView.builder(
//           itemBuilder: (context, index) {
//             Todo item = todos[index];
//             return TodoTile(
//               key: Key(item.id),
//               todo: item,
//               chkboxCallback: (newState) {
//                 data.checkboxCallback(item);
//               },
//               todoType: TodoType.longTerm,
//             );
//           },
//           itemCount: todos.length,
//         );
//       },
//     );
//   }
// }
