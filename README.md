# ui_kit_dam

Kit de componentes de interfaz para Flutter.

## Componentes

- `InfoBadge`: etiqueta informativa.
- `StarRating`: valoración con estrellas.
- `QuantityStepper`: selector numérico (ver abajo).

## QuantityStepper

Selector numérico con botones − y + que mantiene el valor dentro de un rango.

```dart
QuantityStepper(
  min: 1,
  max: 8,
  step: 1,
  initialValue: 1,
  onChanged: (value) => print(value),
  onLimitReached: (limit) => print(limit),
)
```

| Propiedad | Por defecto | Descripción |
|---|---|---|
| `min` | 0 | Valor mínimo |
| `max` | 10 | Valor máximo |
| `step` | 1 | Incremento por pulsación |
| `initialValue` | `min` | Valor inicial |
| `semanticLabel` | `'Cantidad'` | Etiqueta de accesibilidad |
| `decrementTooltip` | `'Restar'` | Tooltip del botón − |
| `incrementTooltip` | `'Sumar'` | Tooltip del botón + |
| `onChanged` | - | Se emite al cambiar el valor |
| `onLimitReached` | - | Se emite al llegar a un límite |