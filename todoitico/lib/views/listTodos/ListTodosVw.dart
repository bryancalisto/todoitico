import 'package:flutter/material.dart';
import 'package:todoitico/views/listTodos/ExitVw.dart';
import 'package:todoitico/views/listTodos/listDailyVw.dart';
import 'package:todoitico/views/listTodos/listLongTermVw.dart';

class ListTodosVw extends StatefulWidget {
  static const String route = 'ListTodosVw';
  const ListTodosVw({Key? key}) : super(key: key);

  @override
  State<ListTodosVw> createState() => _ListTodosVwState();
}

class _ListTodosVwState extends State<ListTodosVw> {
  int _currentViewIndex = 0;
  final List<Widget> _tabsContent = [
    ListDailyVw(),
    ListLongTermVw(),
    ExitVw(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabsContent.length,
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.lock_clock), label: 'Hoy'),
              BottomNavigationBarItem(icon: Icon(Icons.av_timer_outlined), label: 'Después'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configuración'),
            ],
            iconSize: 20,
            onTap: (int index) => setState(() => _currentViewIndex = index),
            currentIndex: _currentViewIndex,
            backgroundColor: Color(0xff711c91),
            selectedItemColor: Color(0xffea00d9),
            showUnselectedLabels: true,
            showSelectedLabels: true,
          ),
          body: _tabsContent[_currentViewIndex]),
    );
  }
}
