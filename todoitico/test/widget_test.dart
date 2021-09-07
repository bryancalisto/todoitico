import 'package:flutter_test/flutter_test.dart';

import 'package:todoitico/main.dart';
import 'package:todoitico/views/listTodosVw.dart';
import 'package:todoitico/widgets/theLoader.dart';

void main() {
  testWidgets('Loader should be displayed when waiting for database at the start of the app',
      (WidgetTester tester) async {
    // ARRANGE
    await tester.pumpWidget(TodoitoApp());
    // ACT
    // ASSERT
    expect(find.byType(TheLoader), findsOneWidget);
  });

  testWidgets('ListTodosVw should be displayed after db has been initialized after the start of the app',
      (WidgetTester tester) async {
    // ARRANGE
    final widget = TodoitoApp();
    // ACT
    await tester.pumpWidget(widget);
    await tester.pumpWidget(widget);
    // ASSERT
    expect(find.byType(TheLoader), findsNothing);
    expect(find.byType(ListTodosVw), findsOneWidget);
  });
}
