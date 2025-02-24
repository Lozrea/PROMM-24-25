import 'package:pokepedia/data/models/habilidad_pokemon.dart';
import 'package:pokepedia/data/models/pokemon.dart';
import 'package:pokepedia/data/models/cad_evolucion_pokemon.dart';
import 'package:pokepedia/data/models/pokemon_moves.dart';
import 'package:pokepedia/data/models/estadistica_pokemon.dart';
import 'package:pokepedia/data/models/pokemon_type.dart';
import 'package:pokepedia/data/models/pokemon_type_effectiveness.dart';
import 'package:pokepedia/core/utils/enums/pokemon_type.dart';
import 'package:pokepedia/core/utils/enums/pokemon_type_effectiveness_enum.dart';
import 'package:pokepedia/core/utils/helpers/format_text_helper.dart';

// Contiene los detalles completos de un Pokémon.
class DetallesPokemon extends Pokemon {
  final String description;
  final int baseExperience;
  final int height;
  final int weight;
  final List<PokemonMoves> moves;
  final List<HabilidadPokemon> abilities;
  final List<EstadisticaPokemon> stats;
  final CadenaEvolucionPokemon evolutionChain;
  final List<PokemonTypeEffectiveness> effectiveness;

  DetallesPokemon({
    required super.id,
    required super.name,
    required super.types,
    required super.sprite,
    required super.isFavorite,
    required this.baseExperience,
    required this.description,
    required this.height,
    required this.weight,
    required this.moves,
    required this.abilities,
    required this.stats,
    required this.evolutionChain,
    required this.effectiveness,
  });

  factory DetallesPokemon.fromJson(Map<String, dynamic> json) {
    final types = (json['types'] as List)
      .map((data) => TiposPokemon.fromJson(data))
      .toList();

    final moves = (json['moves']['nodes'] as List)
      .map((data) => PokemonMoves.fromJson(data))
      .toList();

    final abilities = (json['abilities'] as List)
      .map((data) => HabilidadPokemon.fromJson(data))
      .toList();

    final stats = (json['stats'] as List)
      .map((data) => EstadisticaPokemon.fromJson(data))
      .toList();

    return DetallesPokemon(
      id: json['id'],
      name: json['name'],
      types: types,
      sprite: json['sprites'][0]['front_default'] ?? '',
      isFavorite: false,
      description: FormatTextHelper.formatFlavorText(json['species']),
      baseExperience: json['base_experience'],
      height: json['height'],
      weight: json['weight'],
      moves: moves,
      abilities: abilities,
      stats: stats,
      evolutionChain: CadenaEvolucionPokemon.fromJson(json['species']['evolution_chain']),
      effectiveness: _calculateTotalEffectiveness(types),
    );
  }

  List<PokemonMoves> get sortedMoves {
    return moves..sort((a, b) => a.level.compareTo(b.level));
  }

  static List<PokemonTypeEffectiveness> _calculateTotalEffectiveness(
    List<TiposPokemon> types
  ) {
    final Map<PokemonTypeEnum, int> effectivenessScores = {};

    for (var pokemonType in types) {
      for (var entry in pokemonType.effectiveness.entries) {
        final type = entry.key;

        final effectivenessValue = entry.value.score;

        effectivenessScores[type] = (effectivenessScores[type] ?? 0) + effectivenessValue;
      }
    }

    final List<PokemonTypeEffectiveness> result = [];

    for (var entry in effectivenessScores.entries) {
      result.add(PokemonTypeEffectiveness(
        type: entry.key,
        effectiveness: PokemonTypeEffectivenessEnum.parse(entry.value)
      ));
    }

    return result;
  }

  @override
  String toString() {
    return 'PokemonDetails(id: $id, name: $name)';
  }
}