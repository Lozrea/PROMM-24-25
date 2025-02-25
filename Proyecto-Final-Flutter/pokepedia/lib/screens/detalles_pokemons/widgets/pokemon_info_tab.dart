import 'package:flutter/material.dart';
import 'package:pokepedia/data/models/pokemon_details.dart';
import 'package:pokepedia/screens/detalles_pokemons/widgets/pokemon_abilities.dart';
import 'package:pokepedia/screens/detalles_pokemons/widgets/pokemon_basic_info.dart';
import 'package:pokepedia/screens/detalles_pokemons/widgets/pokemon_stats.dart';
import 'package:pokepedia/screens/widgets_comunes/pokemon_types.dart';
import 'package:pokepedia/screens/widgets_comunes/pokemon_types_effectiveness.dart';

// Widget que combina varios detalles del Pokémon, como la descripción,
// los tipos, la información básica, la efectividad de los tipos, las estadísticas y las habilidades
class PokemonInfoTab extends StatelessWidget {
  final PokemonDetails pokemon;

  const PokemonInfoTab({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                pokemon.description,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontStyle: FontStyle.italic
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PokemonTypes(pokemon: pokemon)
            ),
            PokemonBasicInfo(pokemon: pokemon),
            const SizedBox(height: 16),
            PokemonTypesEffectiveness(pokemon: pokemon),
            const SizedBox(height: 16),
            PokemonStats(pokemon: pokemon),
            const SizedBox(height: 16),
            PokemonAbilities(pokemon: pokemon)
          ]
        ),
      )
    );
  }
}