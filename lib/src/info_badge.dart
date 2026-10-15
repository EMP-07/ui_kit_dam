import 'package:flutter/material.dart';

/// Etiqueta informativa sin estado
class InfoBadge extends StatelessWidget {

  /// Crea una etiqueta con el texto "label"
  const InfoBadge({super.key, required this.label});

  /// Texto que muestra la etiqueta
  final String label; 

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label));
  }
}