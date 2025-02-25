import 'package:flutter/material.dart';
import 'package:pokepedia/data/models/pokemon.dart';
import 'package:pokepedia/screens/widgets_comunes/pokemon_type_badge.dart';

// Widget que muestra los iconos de los tipos al que pertenece un POkemon
class PokemonTypes extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonTypes({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0, // Espacio horizontal entre los elementos
      runSpacing: 4.0, // Espacio vertical entre líneas de elementos
      children: pokemon.types.map((pokemonType) {
        return PokemonTypeBadge(type: pokemonType.type);
      }).toList()
    );
  }
}
