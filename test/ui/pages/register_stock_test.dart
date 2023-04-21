import 'package:app_flutter/app/ui/pages/register_stock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Possui SingleChildScrollView', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RegisterStock(),
      ),
    );

    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });
}
