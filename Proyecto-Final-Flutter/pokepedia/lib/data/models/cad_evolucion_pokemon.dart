import 'package:pokepedia/data/models/pokemon.dart';

// Clase que representa la cadena de evolución de un Pokémon
class CadenaEvolucionPokemon {
  final List<Pokemon> stages;

  CadenaEvolucionPokemon({required this.stages});

  factory CadenaEvolucionPokemon.fromJson(Map<String, dynamic> json) {
    final stages = (json['species'] as List? ?? [])
      .expand((speciesInfo) => speciesInfo['pokemons'] as List? ?? [])
      .map((pokemon) => Pokemon.fromJson(pokemon))
      .toList();

    return CadenaEvolucionPokemon(stages: stages);
  }
}