import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/models/todo.dart';
import 'package:todoitico/services/theDatabaseSvc.dart';
import 'package:todoitico/utils/dateHelpers.dart';
import 'package:todoitico/views/manageTodoVw.dart';
import 'package:todoitico/widgets/theLoader.dart';
import 'package:todoitico/widgets/todoTile.dart';

class ListDailyVw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _primaryColor = Theme.of(context).colorScheme.primary;
    final _onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    return Scaffold(
      backgroundColor: _primaryColor,
      floatingActionButton: DraggableFab(
        child: FloatingActionButton(
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
                    todoType: TodoType.daily,
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
        stream: Provider.of<BaseDatabaseService>(context).suscribeForDailyTodos(DateTime.now()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 20),
                  child: Column(
                    children: [
                      Text(
                        'P A R A  H O Y',
                        style: TextStyle(
                            fontSize: 18, color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateHelpers.inSpanishDate(DateTime.now()),
                        style: TextStyle(fontSize: 12, color: Colors.white, letterSpacing: 2),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Theme.of(context).colorScheme.onPrimary, width: 4),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: (snapshot.data as List<Todo>)
                                .map(
                                  (item) => TodoTile(
                                    key: Key(item.id),
                                    todo: item,
                                    chkboxCallback: (newState) {
                                      Provider.of<BaseDatabaseService>(context, listen: false)
                                          .checkboxCallback(item, TodoType.daily);
                                    },
                                    todoType: TodoType.daily,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            if (snapshot.error.toString() == "PlatformException(get-failed, Client is offline, null, null)") {
              return Center(child: Text('Se requiere acceso a Internet'));
            }
            return Center(child: Text('Error listDailyVw: ${snapshot.error.toString()}'));
          } else {
            return Center(child: TheLoader());
          }
        },
      ),
    );
  }
}
