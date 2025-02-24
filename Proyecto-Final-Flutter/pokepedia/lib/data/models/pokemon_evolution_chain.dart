import 'package:pokepedia/data/models/pokemon.dart';

// Clase que representa la cadena de evolución de un Pokémon
class PokemonEvolutionChain {
  final List<Pokemon> stages;

  PokemonEvolutionChain({required this.stages});

  factory PokemonEvolutionChain.fromJson(Map<String, dynamic> json) {
    final stages = (json['species'] as List? ?? [])
      .expand((speciesInfo) => speciesInfo['pokemons'] as List? ?? [])
      .map((pokemon) => Pokemon.fromJson(pokemon))
      .toList();

    return PokemonEvolutionChain(stages: stages);
  }
}