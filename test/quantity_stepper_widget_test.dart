import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_dam/ui_kit_dam.dart';

/// Envuelve el widget en MaterialApp/Scaffold, que necesita para funcionar.
Widget wrap(Widget child) =>
    MaterialApp(home: Scaffold(body: Center(child: child)));

void main() {
  testWidgets('sumar muestra el nuevo valor y emite onChanged',
      (tester) async {
    int? received;
    await tester.pumpWidget(wrap(QuantityStepper(onChanged: (v) => received = v)));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // redibuja tras setState

    expect(find.text('1'), findsOneWidget);
    expect(received, 1);
  });

  testWidgets('el botón − está desactivado en el mínimo', (tester) async {
    await tester.pumpWidget(wrap(const QuantityStepper()));

    final button = tester.widget<IconButton>(
      find.widgetWithIcon(IconButton, Icons.remove),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets('onLimitReached recibe StepperLimit.max', (tester) async {
    StepperLimit? limit;
    await tester.pumpWidget(wrap(QuantityStepper(
      max: 2,
      initialValue: 1,
      onLimitReached: (l) => limit = l,
    )));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(limit, StepperLimit.max);
  });
}