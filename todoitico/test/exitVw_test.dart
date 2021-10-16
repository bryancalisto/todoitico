import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todoitico/services/authSvc.dart';
import 'package:todoitico/services/theDatabaseSvc.dart';
import 'package:todoitico/views/listTodos/ExitVw.dart';
import 'package:todoitico/views/loginVw.dart';

import 'helpers.dart';

class MockAuthService extends Mock implements BaseAuthService {}

class MockTheDatabaseService extends Mock implements BaseDatabaseService {}

void main() {
  final mockAuthService = MockAuthService();
  final mockDatabaseService = MockTheDatabaseService();

  testWidgets('button push should call logout function', (WidgetTester tester) async {
    when(() => mockAuthService.logout()).thenAnswer((_) => Future.value());

    await tester.pumpWidget(makeTestableWidget(
      child: ExitVw(),
      authService: mockAuthService,
      databaseService: mockDatabaseService,
    ));

    await tester.tap(find.byType(TextButton));
    verify(() => mockAuthService.logout());
  });

  testWidgets('effective logout should redirect user to login', (WidgetTester tester) async {
    when(() => mockAuthService.logout()).thenAnswer((_) => Future.value());

    await tester.pumpWidget(makeTestableWidget(
      child: ExitVw(),
      authService: mockAuthService,
      databaseService: mockDatabaseService,
    ));

    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();
    expect(find.byType(LoginVw), findsOneWidget);
  });
}
