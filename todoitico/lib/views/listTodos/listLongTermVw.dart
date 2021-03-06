import 'package:draggable_fab/draggable_fab.dart';
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
    final _primaryColor = Theme.of(context).colorScheme.primary;
    final _onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    return Scaffold(
      backgroundColor: _primaryColor,
      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
          backgroundColor: _primaryColor,
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
            color: _onPrimaryColor,
            size: 39,
          ),
        ),
      ),
      body: StreamBuilder<List<Todo>>(
        stream: Provider.of<BaseDatabaseService>(context).suscribeForLongTermTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Todo> todos = (snapshot.data as List<Todo>);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 20),
                  child: Text(
                    'P E N D I E N T E S:  ${todos.length}',
                    style: TextStyle(fontSize: 18, color: _onPrimaryColor),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: _onPrimaryColor, width: 4),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListView(
                      children: todos
                          .map(
                            (item) => TodoTile(
                              key: Key(item.id),
                              todo: item,
                              chkboxCallback: (newState) {
                                Provider.of<BaseDatabaseService>(context, listen: false)
                                    .checkboxCallback(item, TodoType.longTerm);
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
