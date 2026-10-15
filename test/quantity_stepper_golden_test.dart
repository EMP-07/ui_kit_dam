import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_dam/ui_kit_dam.dart';

void main() {
  testWidgets('golden con valor 5', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(child: QuantityStepper(initialValue: 5)),
        ),
      ),
    );

    await expectLater(
      find.byType(QuantityStepper),
      matchesGoldenFile('goldens/quantity_stepper_5.png'),
    );
  });
}