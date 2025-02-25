import 'package:flutter/material.dart';
import 'package:pokepedia/data/models/pokemon_details.dart';
import 'package:pokepedia/screens/widgets_comunes/nothing_found_indicator.dart';
import 'package:pokepedia/screens/widgets_comunes/pokemon_card.dart';

// Widget que muestra una lista de las evoluciones de un Pokémon.
// Si el Pokémon no tiene más que una etapa de evolución, se muestra
// un indicador de que no se encontraron evoluciones. Si existen múltiples etapas,
// se construye una lista de tarjetas que representan las diferentes etapas de evolución.
class PokemonEvolutionsTab extends StatelessWidget {
  final PokemonDetails pokemon;

  const PokemonEvolutionsTab({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    if (pokemon.evolutionChain.stages.length == 1) {
      return const NothingFoundIndicator();
    }

    return ListView.builder(
      addRepaintBoundaries: true,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      shrinkWrap: true,
      itemCount: pokemon.evolutionChain.stages.length,
      itemBuilder: (context, index) {
        return PokemonCard(pokemon: pokemon.evolutionChain.stages[index]);
      }
    );
  }
}