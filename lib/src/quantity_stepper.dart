import 'package:flutter/material.dart';

/// Límite del rango que se ha alcanzado un "QuantityStepper"
enum StepperLimit { /// Se ha alcanzado el valor mínimo 
  min, 
  /// Se ha alcanzado el valor máximo
  max 
  }

/// Función que se llama cuando el valor llega a un límite
/// Recibe el "StepperLimit" alcanzado
typedef LimitReached = void Function(StepperLimit limit);

/// Calcula el siguiente valor sumando "delta" a "current"
///El resultado queda siempre limitado al rango "min-max"
int nextStepperValue({
  required int current,
  required int delta,
  required int min,
  required int max,
}) {
  return (current + delta).clamp(min, max);
}

/// Selector numérico con botones para sumar y restar
/// El valor nunca sale del rango "min-max" y los botones se desactivan al llegar a cada límite
/// 
/// Ejemplo de uso:
/// QuantityStepper(
/// min: 1,
/// max: 8,
/// onChanged: (value) => print('Entradas: $value'),
/// onLimitReached: (limit) {
/// if (limit == StepperLimit.max) print('Máximo alcanzado');
/// })

class QuantityStepper extends StatefulWidget {
///Se crea un selector de cantidad
/// Se lanza un error en modo debug si "min >= max, step <= 0" o "initialValue" quequeda fuera del rango
  const QuantityStepper({
    super.key,
    this.min = 0, 
    this.max = 10,
    this.step = 1,
    this.initialValue,
    this.semanticLabel = 'Cantidad',
    this.decrementTooltip = 'Restar',
    this.incrementTooltip = 'Sumar',
    this.onChanged,
    this.onLimitReached,
  })  : assert(min < max, 'min debe ser menor que max'),
        assert(step > 0, 'step debe ser mayor que 0'),
        assert(
          (initialValue ?? min) >= min && (initialValue ?? min) <= max,
          'initialValue debe estar entre min y max',
        );

/// Valor mínimo permitido. Por defecto 0
  final int min; 
  /// Valor máximo permitido. Por defecto 10
  final int max; 
  /// Cantidad que suma o resta cada pulsación. Por defecto 1
  final int step; 
  /// Valor inicial. Si es null, se usa "min"
  final int? initialValue; 
  /// Etiqueta de accesibilidad del componente
  final String semanticLabel; 
  /// Texto del tooltip del botón de restar
  final String decrementTooltip; 
  /// Texto del tooltip del botón de sumar
  final String incrementTooltip; 
  /// Se emite con el nuevo valor cada vez que cambia
  final ValueChanged<int>? onChanged; 
  /// Se emite cuando el valor llega al mínimo o al máximo
  final LimitReached? onLimitReached;  

  @override
  State<QuantityStepper> createState() => _QuantityStepperState();
}

class _QuantityStepperState extends State<QuantityStepper> {
  late int _value;

  int _clamp(int v) => v.clamp(widget.min, widget.max);

  @override
  void initState() {
    super.initState();
    _value = _clamp(widget.initialValue ?? widget.min);
  }

  @override
  void didUpdateWidget(covariant QuantityStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = _clamp(_value); // si cambian min/max, reajusta el valor
  }

  void _change(int delta) {
  final newValue = nextStepperValue(
  current: _value,
  delta: delta,
  min: widget.min,
  max: widget.max,
);
  if (newValue == _value) return; // sin cambio, no se emite nada

  setState(() => _value = newValue);
  widget.onChanged?.call(newValue);

  if (newValue == widget.max) {
    widget.onLimitReached?.call(StepperLimit.max);
  } else if (newValue == widget.min) {
    widget.onLimitReached?.call(StepperLimit.min);
  }
}

  @override
  Widget build(BuildContext context) {
    final canDecrement = _value > widget.min;
    final canIncrement = _value < widget.max;

    return Semantics(
      label: widget.semanticLabel,
      value: '$_value',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            tooltip: widget.decrementTooltip,
            onPressed: canDecrement ? () => _change(-widget.step) : null,
          ),
          Text('$_value'),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: widget.incrementTooltip,
            onPressed: canIncrement ? () => _change(widget.step) : null,
          ),
        ],
      ),
    );
  }
}