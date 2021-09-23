import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'package:todoitico/main.dart';
import 'package:todoitico/models/todo.dart';
import 'package:todoitico/views/listTodosVw.dart';
import 'package:todoitico/widgets/theLoader.dart';

class MockTheDatabaseService extends Mock implements BaseDatabaseService, ChangeNotifier {}

void main() {
  // STUBS
  MockTheDatabaseService mockTheDatabaseService = MockTheDatabaseService();
  final todos = Future.value([
    Todo(
      id: 1,
      title: 'title',
      created: DateTime.parse('2021-12-25'),
      content: 'content',
      creator: 'creator',
      limitDate: DateTime.now().add(Duration(days: 3)),
      status: 'P',
    )
  ]);

  Widget makeTestableWidget({Widget child}) => ChangeNotifierProvider<BaseDatabaseService>.value(
        value: mockTheDatabaseService,
        child: MaterialApp(
          home: child,
        ),
        // child:
      );

  testWidgets('Loader should be displayed when waiting for database at the start of the app',
      (WidgetTester tester) async {
    // ARRANGE
    when(mockTheDatabaseService.allTodoEntries).thenAnswer((_) => Future.delayed(Duration(milliseconds: 100)));
    when(mockTheDatabaseService.getTodoCount(true)).thenAnswer((_) => Future.value(1));
    when(mockTheDatabaseService.getTodoCount(false)).thenAnswer((_) => Future.value(1));
    // ACT
    await tester.runAsync(() async {
      await tester.pumpWidget(TodoitoApp(mockTheDatabaseService));
      await tester.pump();
    }).then((value) {
      // ASSERT
      expect(find.byType(TheLoader), findsOneWidget);
    });
  });

  testWidgets('ListTodosVw should be displayed after db has been initialized after the start of the app',
      (WidgetTester tester) async {
    // ARRANGE
    when(mockTheDatabaseService.allTodoEntries).thenAnswer((_) => todos);
    when(mockTheDatabaseService.getTodoCount(true)).thenAnswer((_) => Future.value(1));
    when(mockTheDatabaseService.getTodoCount(false)).thenAnswer((_) => Future.value(1));
    final widget = TodoitoApp(mockTheDatabaseService);
    // ACT
    await tester.runAsync(() async {
      await tester.pumpWidget(widget);
      await tester.pump();
    }).then((value) {
      // ASSERT
      expect(find.byType(TheLoader), findsNothing);
      expect(find.byType(ListTodosVw), findsOneWidget);
    });
  });

  group('LIST TODO VIEW', () {
    testWidgets('Total pending todo count should be displayed', (WidgetTester tester) async {
      // ARRANGE
      when(mockTheDatabaseService.allTodoEntries).thenAnswer((_) => todos);
      when(mockTheDatabaseService.getTodoCount(true)).thenAnswer((_) => Future.value(69));
      final mockApp = makeTestableWidget(child: ListTodosVw());

      // ACT
      await tester.runAsync(() async {
        await tester.pumpWidget(mockApp);
        await tester.pump();
      }).then((value) {
        // ASSERT
        verify(mockTheDatabaseService.getTodoCount(true));
        expect(find.text('Pendientes: 69'), findsOneWidget);
      });
    });
  });

  group('TODO TILE', () {
    testWidgets('Tap on a todo tile should display edit page for that tile', (WidgetTester tester) async {
      // ARRANGE
      when(mockTheDatabaseService.allTodoEntries).thenAnswer((_) => todos);
      when(mockTheDatabaseService.getTodoCount(true)).thenAnswer((_) => Future.value(1));
      when(mockTheDatabaseService.getTodoCount(false)).thenAnswer((_) => Future.value(1));
      final mockApp = TodoitoApp(mockTheDatabaseService);

      // ACT
      await tester.runAsync(() async {
        await tester.pumpWidget(mockApp);
        await tester.pumpAndSettle();
        var tile = find.byKey(Key('1')).first;
        await tester.pumpAndSettle();
        await tester.tap(tile);
        await tester.pumpAndSettle();
      }).then((value) {
        // ASSERT
        verify(mockTheDatabaseService.allTodoEntries);
        verify(mockTheDatabaseService.getTodoCount(true));
        verify(mockTheDatabaseService.getTodoCount(false));
        expect(find.text('content'), findsOneWidget);
        expect(find.text('creator'), findsOneWidget);
      });
    });
  });
}
