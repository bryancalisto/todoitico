import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/models/todo.dart';
import 'package:todoitico/services/authSvc.dart';
import 'package:todoitico/services/theDatabaseSvc.dart';
import 'package:todoitico/views/confirmDeleteVw.dart';
import 'package:todoitico/views/listTodos/ListTodosVw.dart';
import 'package:todoitico/views/listTodos/listLongTermVw.dart';
import 'package:todoitico/views/loginVw.dart';
import 'package:todoitico/views/manageTodoVw.dart';
import 'package:todoitico/widgets/todoTile.dart';

class MockAuthService extends Mock implements BaseAuthService {}

class MockTheDatabaseService extends Mock implements BaseDatabaseService {}

void main() {
  // STUBS
  MockAuthService mockAuthService = MockAuthService();
  MockTheDatabaseService mockTheDatabaseService = MockTheDatabaseService();

  List<Todo> todos = [
    Todo(id: 'id1', limitDate: DateTime.now(), created: DateTime.now(), content: 'content1', status: 'P'),
    Todo(id: 'id2', created: DateTime.now(), content: 'content2', status: 'P')
  ];

  Widget makeTestableWidget({required Widget child}) => MultiProvider(
    providers: [
      Provider<BaseAuthService>.value(value: mockAuthService),
      ChangeNotifierProvider<BaseDatabaseService>.value(value: mockTheDatabaseService),
    ],
    builder: (context, widget) {
      return MaterialApp(
        home: child,
        routes: {
          LoginVw.route: (context) => LoginVw(),
          ListTodosVw.route: (context) => ListTodosVw(),
        },
      );
    },
  );

  group('Listing todos', (){
    testWidgets('Same number of queried todos should be in the listview', (WidgetTester tester) async {
      // ARRANGE
      when(() => mockTheDatabaseService.getLongTermTodos()).thenAnswer((_) async => todos);
      // ACT
      await tester.pumpWidget(makeTestableWidget(child: ListLongTermVw()));
      await tester.pump();
      // ASSERT
      expect(find.byType(TodoTile), findsNWidgets(todos.length));
    });
  });

  group('Adding todos', (){
    testWidgets('Tapping floating button should display manageTodoVw', (WidgetTester tester) async {
      // ARRANGE
      when(() => mockTheDatabaseService.getLongTermTodos()).thenAnswer((_) async => todos);
      // ACT
      await tester.pumpWidget(makeTestableWidget(child: ListLongTermVw()));
      await tester.pump();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      // ASSERT
      expect(find.byType(ManageTodoVw), findsOneWidget);
    });
  });

  group('Removing todos', (){
    testWidgets('Tapping floating button should display manageTodoVw', (WidgetTester tester) async {
      // ARRANGE
      when(() => mockTheDatabaseService.getLongTermTodos()).thenAnswer((_) async => todos);
      // ACT
      await tester.pumpWidget(makeTestableWidget(child: ListLongTermVw()));
      await tester.pump();
      await tester.longPress(find.text(todos[0].content));
      await tester.pumpAndSettle();
      // ASSERT
      expect(find.byType(ConfirmDeleteVw), findsOneWidget);
    });
  });

  group('Updating todos', (){
    testWidgets('Tapping a todo should display manageTodoVw', (WidgetTester tester) async {
      // ARRANGE
      when(() => mockTheDatabaseService.getLongTermTodos()).thenAnswer((_) async => todos);
      // ACT
      await tester.pumpWidget(makeTestableWidget(child: ListLongTermVw()));
      await tester.pump();
      await tester.tap(find.text(todos[0].content));
      await tester.pumpAndSettle();
      // ASSERT
      expect(find.byType(ManageTodoVw), findsOneWidget);
    });
  });

//   testWidgets('Login callback should not be called if user and passwd inputs are empty', (WidgetTester tester) async {
//     // ARRANGE
//     when(() => mockAuthService.login('', '')).thenAnswer((_) async => false);
//     // ACT
//     await tester.pumpWidget(makeTestableWidget(child: LoginVw()));
//     await tester.pump();
//     await tester.tap(find.byKey(Key('loginBtn')));
//     await tester.pump();
//     // ASSERT
//     verifyNever(() => mockAuthService.login('', ''));
//   });
//
//   testWidgets('Login callback should be called once if user and passwd inputs are not empty',
//           (WidgetTester tester) async {
//         // ARRANGE
//         when(() => mockAuthService.login(any(that: isNotEmpty), any(that: isNotEmpty))).thenAnswer((_) async => false);
//         // ACT
//         await tester.pumpWidget(makeTestableWidget(child: LoginVw()));
//         await tester.enterText(find.byKey(Key('usernameInput')), 'test1 ');
//         await tester.enterText(find.byKey(Key('passwdInput')), '  test2');
//         await tester.tap(find.byKey(Key('loginBtn')));
//         // ASSERT
//         verify(() => mockAuthService.login('test1', 'test2'));
//       });
//
//   testWidgets('Error message should be displayed if login was started but not went successful',
//           (WidgetTester tester) async {
//         // ARRANGE
//         when(() => mockAuthService.login(any(that: isNotEmpty), any(that: isNotEmpty))).thenAnswer((_) async => false);
//         // ACT
//         await tester.runAsync(() async {
//           await tester.pumpWidget(makeTestableWidget(child: LoginVw()));
//           await tester.enterText(find.byKey(Key('usernameInput')), 'test1 ');
//           await tester.enterText(find.byKey(Key('passwdInput')), '  test2');
//           await tester.tap(find.byKey(Key('loginBtn')));
//           await tester.pumpAndSettle();
//         }).then((value) {
//           // ASSERT
//           verify(() => mockAuthService.login('test1', 'test2'));
//           expect(find.text('Error. Reintente acceder.'), findsOneWidget);
//         });
//       });
//
//   testWidgets('Should be redirected to ListTodosVw if login was successful', (WidgetTester tester) async {
//     // ARRANGE
//     when(() => mockAuthService.login(any(that: isNotEmpty), any(that: isNotEmpty))).thenAnswer((_) async => true);
//     when(() => mockTheDatabaseService.getLongTermTodos()).thenAnswer((_) async => Future.value(todos));
//     when(() => mockTheDatabaseService.getDailyTodos(any(that: isNotNull)))
//         .thenAnswer((_) async => Future.value(todos));
//     // ACT
//     await tester.runAsync(() async {
//       await tester.pumpWidget(makeTestableWidget(child: LoginVw()));
//       await tester.enterText(find.byKey(Key('usernameInput')), 'test1 ');
//       await tester.enterText(find.byKey(Key('passwdInput')), '  test2');
//       await tester.tap(find.byKey(Key('loginBtn')));
//       await tester.pumpAndSettle();
//     }).then((value) {
//       // ASSERT
//       verify(() => mockAuthService.login('test1', 'test2'));
//       expect(find.byType(ListTodosVw), findsOneWidget);
//     });
//   });
}
