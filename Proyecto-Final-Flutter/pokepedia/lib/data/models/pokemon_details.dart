import 'package:pokepedia/data/models/pokemon.dart';
import 'package:pokepedia/data/models/pokemon_ability.dart';
import 'package:pokepedia/data/models/pokemon_evolution_chain.dart';
import 'package:pokepedia/data/models/pokemon_move.dart';
import 'package:pokepedia/data/models/pokemon_stat.dart';
import 'package:pokepedia/data/models/pokemon_type.dart';
import 'package:pokepedia/data/models/pokemon_type_effectiveness.dart';
import 'package:pokepedia/core/utils/enums/pokemon_type.dart';
import 'package:pokepedia/core/utils/enums/pokemon_type_effectiveness.dart';
import 'package:pokepedia/core/utils/helpers/format_text_helper.dart';

// Contiene los detalles completos de un Pokémon.
class PokemonDetails extends Pokemon {
  final String description;
  final int baseExperience;
  final int height;
  final int weight;
  final List<PokemonMove> moves;
  final List<PokemonAbility> abilities;
  final List<PokemonStat> stats;
  final PokemonEvolutionChain evolutionChain;
  final List<PokemonTypeEffectiveness> effectiveness;

  PokemonDetails({
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

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    final types = (json['types'] as List)
      .map((data) => PokemonType.fromJson(data))
      .toList();

    final moves = (json['moves']['nodes'] as List)
      .map((data) => PokemonMove.fromJson(data))
      .toList();

    final abilities = (json['abilities'] as List)
      .map((data) => PokemonAbility.fromJson(data))
      .toList();

    final stats = (json['stats'] as List)
      .map((data) => PokemonStat.fromJson(data))
      .toList();

    return PokemonDetails(
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
      evolutionChain: PokemonEvolutionChain.fromJson(json['species']['evolution_chain']),
      effectiveness: _calculateTotalEffectiveness(types),
    );
  }

  List<PokemonMove> get sortedMoves {
    return moves..sort((a, b) => a.level.compareTo(b.level));
  }

  static List<PokemonTypeEffectiveness> _calculateTotalEffectiveness(
    List<PokemonType> types
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