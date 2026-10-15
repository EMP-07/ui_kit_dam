import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_dam/ui_kit_dam.dart';

void main() {
  group('nextStepperValue', () {
    test('suma dentro del rango', () {
      expect(nextStepperValue(current: 3, delta: 1, min: 0, max: 10), 4);
    });

    test('resta dentro del rango', () {
      expect(nextStepperValue(current: 3, delta: -2, min: 0, max: 10), 1);
    });

    test('no pasa del máximo', () {
      expect(nextStepperValue(current: 9, delta: 5, min: 0, max: 10), 10);
    });

    test('no baja del mínimo', () {
      expect(nextStepperValue(current: 1, delta: -5, min: 0, max: 10), 0);
    });

    test('en el límite se queda igual', () {
      expect(nextStepperValue(current: 10, delta: 1, min: 0, max: 10), 10);
    });
  });
}