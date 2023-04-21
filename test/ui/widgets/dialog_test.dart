import 'package:app_flutter/app/ui/pages/register_stock.dart';
import 'package:app_flutter/app/ui/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Possui dialog', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Dialogg(),
      ),
    );

    expect(find.byType(Container), findsOneWidget);
  });
}
