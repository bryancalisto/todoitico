import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todoitico/models/todo.dart';
import 'package:todoitico/services/authSvc.dart';
import 'package:todoitico/services/theDatabaseSvc.dart';
import 'package:todoitico/views/confirmDeleteVw.dart';
import 'package:todoitico/views/listTodos/listDailyVw.dart';
import 'package:todoitico/views/manageTodoVw.dart';
import 'package:todoitico/widgets/todoTile.dart';

import 'helpers.dart';

class MockAuthService extends Mock implements BaseAuthService {}

class MockTheDatabaseService extends Mock implements BaseDatabaseService {}

void main() {
  // STUBS/MOCKS
  MockAuthService mockAuthService = MockAuthService();
  MockTheDatabaseService mockTheDatabaseService = MockTheDatabaseService();

  List<Todo> todos = [
    Todo(id: 'id1', limitDate: DateTime.now(), created: DateTime.now(), content: 'content1', status: 'P'),
    Todo(id: 'id2', created: DateTime.now(), content: 'content2', status: 'P')
  ];

  returnTodos() {
    when(() => mockTheDatabaseService.suscribeForDailyTodos(any(that: isNotNull)))
        .thenAnswer((_) => Stream.value(todos));
  }

  group('Listing todos', () {
    testWidgets('Same number of queried todos should be in the listview', (WidgetTester tester) async {
      // ARRANGE
      returnTodos();
      // ACT
      await tester.pumpWidget(makeTestableWidget(
        child: ListDailyVw(),
        authService: mockAuthService,
        databaseService: mockTheDatabaseService,
      ));
      await tester.pump();
      // ASSERT
      expect(find.byType(TodoTile), findsNWidgets(todos.length));
    });
  });

  group('Adding todos', () {
    testWidgets('Tapping floating button should display manageTodoVw', (WidgetTester tester) async {
      // ARRANGE
      returnTodos();
      // ACT
      await tester.pumpWidget(makeTestableWidget(
        child: ListDailyVw(),
        authService: mockAuthService,
        databaseService: mockTheDatabaseService,
      ));
      await tester.pump();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      // ASSERT
      expect(find.byType(ManageTodoVw), findsOneWidget);
    });
  });

  group('Removing todos', () {
    testWidgets('Tapping floating button should display manageTodoVw', (WidgetTester tester) async {
      // ARRANGE
      returnTodos();
      // ACT
      await tester.pumpWidget(makeTestableWidget(
        child: ListDailyVw(),
        authService: mockAuthService,
        databaseService: mockTheDatabaseService,
      ));
      await tester.pump();
      await tester.longPress(find.text(todos[0].content));
      await tester.pumpAndSettle();
      // ASSERT
      expect(find.byType(ConfirmDeleteVw), findsOneWidget);
    });
  });

  group('Updating todos', () {
    testWidgets('Tapping a todo should display manageTodoVw', (WidgetTester tester) async {
      // ARRANGE
      returnTodos();
      // ACT
      await tester.pumpWidget(makeTestableWidget(
        child: ListDailyVw(),
        authService: mockAuthService,
        databaseService: mockTheDatabaseService,
      ));
      await tester.pump();
      await tester.tap(find.text(todos[0].content));
      await tester.pumpAndSettle();
      // ASSERT
      expect(find.byType(ManageTodoVw), findsOneWidget);
    });
  });
}
