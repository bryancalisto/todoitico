import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/services/authSvc.dart';
import 'package:todoitico/views/listTodosVw.dart';
import 'package:todoitico/views/loginVw.dart';

class MockAuthService extends Mock implements BaseAuthService {}

void main() {
  // STUBS
  MockAuthService mockAuthService = MockAuthService();

  Widget makeTestableWidget({Widget child}) => Provider<BaseAuthService>.value(
        value: mockAuthService,
        child: MaterialApp(
          home: child,
          routes: {
            LoginVw.route: (context) => LoginVw(),
            ListTodosVw.route: (context) => ListTodosVw(),
          },
        ),
        // child:
      );

  testWidgets('Login callback should not be called if user and passwd inputs are empty', (WidgetTester tester) async {
    // ARRANGE
    when(mockAuthService.login('', '')).thenAnswer((_) async => false);
    // ACT
    await tester.pumpWidget(makeTestableWidget(child: LoginVw()));
    await tester.pump();
    await tester.tap(find.byKey(Key('loginBtn')));
    await tester.pump();
    // ASSERT
    verifyNever(mockAuthService.login('', ''));
  });

  testWidgets('Login callback should be called once if user and passwd inputs are not empty',
      (WidgetTester tester) async {
    // ARRANGE
    when(mockAuthService.login(argThat(isNotEmpty), argThat(isNotEmpty))).thenAnswer((_) async => false);
    // ACT
    await tester.pumpWidget(makeTestableWidget(child: LoginVw()));
    await tester.enterText(find.byKey(Key('usernameInput')), 'test1 ');
    await tester.enterText(find.byKey(Key('passwdInput')), '  test2');
    await tester.tap(find.byKey(Key('loginBtn')));
    // ASSERT
    verify(mockAuthService.login('test1', 'test2'));
  });

  testWidgets('Error message should be displayed if login was started but not went successful', (WidgetTester tester) async {
    // ARRANGE
    when(mockAuthService.login(argThat(isNotEmpty), argThat(isNotEmpty))).thenAnswer((_) async => false);
    // ACT
    await tester.runAsync(() async {
      await tester.pumpWidget(makeTestableWidget(child: LoginVw()));
      await tester.enterText(find.byKey(Key('usernameInput')), 'test1 ');
      await tester.enterText(find.byKey(Key('passwdInput')), '  test2');
      await tester.tap(find.byKey(Key('loginBtn')));
      await tester.pumpAndSettle();
    }).then((value) {
      // ASSERT
      verify(mockAuthService.login('test1', 'test2'));
      expect(find.text('Error. Reintente acceder.'), findsOneWidget);
    });
  });

  // testWidgets('Should be redirected to ListTodosVw if login was successful', (WidgetTester tester) async {
  //   // ARRANGE
  //   when(mockAuthService.login(argThat(isNotEmpty), argThat(isNotEmpty))).thenAnswer((_) async => true);
  //   // ACT
  //   await tester.runAsync(() async {
  //     await tester.pumpWidget(makeTestableWidget(child: LoginVw()));
  //     await tester.enterText(find.byKey(Key('usernameInput')), 'test1 ');
  //     await tester.enterText(find.byKey(Key('passwdInput')), '  test2');
  //     await tester.tap(find.byKey(Key('loginBtn')));
  //     await tester.pumpAndSettle();
  //   }).then((value) {
  //     // ASSERT
  //     verify(mockAuthService.login('test1', 'test2'));
  //     expect(find.byType(ListTodosVw), findsOneWidget);
  //   });
  // });
}
