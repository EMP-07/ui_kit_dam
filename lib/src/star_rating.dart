import 'package:flutter/material.dart';

/// Valoración con estrellas
class StarRating extends StatelessWidget {
  /// Crea una valoración de "rating" estrellas sobre "maxStars"
  const StarRating({ 
    super.key,
    required this.rating,
    this.maxStars = 5,
    this.onChanged,
  });
  /// Número de estrellas marcadas
  final int rating; 
  /// Número total de estrellas. Por defecto 5
  final int maxStars;  
  /// Se emite con la nueva valoración al pulsar una estrella
  final ValueChanged<int>? onChanged; 

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (i) {
        return IconButton(
          icon: Icon(i < rating ? Icons.star : Icons.star_border),
          onPressed: onChanged == null ? null : () => onChanged!(i + 1),
        );
      }),
    );
  }
}