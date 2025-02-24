import 'package:pokepedia/core/utils/enums/pokemon_type.dart';
import 'package:pokepedia/core/utils/enums/pokemon_type_effectiveness.dart';

// Representa la efectividad de un tipo de Pokémon contra otro.
class PokemonTypeEffectiveness {
  final PokemonTypeEnum type;
  final PokemonTypeEffectivenessEnum effectiveness;

  PokemonTypeEffectiveness({
    required this.type,
    required this.effectiveness
  });
}