import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/models/todo.dart';
import 'package:todoitico/services/theDatabaseSvc.dart';
import 'package:todoitico/views/manageTodoVw.dart';
import 'package:todoitico/widgets/theLoader.dart';
import 'package:todoitico/widgets/todoTile.dart';

class ListLongTermVw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        shape: StadiumBorder(
          side: BorderSide(color: Colors.white70, width: 5),
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: ManageTodoVw(
                  todoType: TodoType.longTerm,
                ),
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 39,
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<BaseDatabaseService>(context).getLongTermTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                    Icon(
                      Icons.all_inclusive,
                      size: 23,
                    ),
                    SizedBox(width: 5),
                    Text(
                      // 'Pendientes: ${snapshot.data}',
                      'Pendientes: ${(snapshot.data as List<Todo>).length}',
                      style: TextStyle(fontSize: 22),
                    ),
                  ]),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 4),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    // child: LongTermTodoList(todos: snapshot.data as List<Todo>),
                    child: ListView(
                      children: (snapshot.data as List<Todo>)
                          .map(
                            (item) => TodoTile(
                              key: Key(item.id),
                              todo: item,
                              chkboxCallback: (newState) {
                                Provider.of<BaseDatabaseService>(context, listen: false).checkboxCallback(item, TodoType.longTerm);
                              },
                              todoType: TodoType.longTerm,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            if (snapshot.error.toString() == "PlatformException(get-failed, Client is offline, null, null)") {
              return Center(child: Text('Se requiere acceso a Internet'));
            }
            return Center(child: Text('Error listTodosVw: ${snapshot.error.toString()}'));
          } else {
            return Center(child: TheLoader());
          }
        },
      ),
    );
  }
}
