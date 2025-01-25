import 'package:pokepedia/models/pokemon_habilidad.dart';
import 'package:pokepedia/models/pokemon_tipo.dart';
import 'package:pokepedia/models/pokemon_estadistica.dart';

class PokemonDetail {
  final int id;
  final String name;
  final int weight;
  final int height;
  final bool isDefault;
  final String speciesName;
  final String? officialFrontDefaultImg;
  final String? officialFrontShinyImg;
  final List<Type> types; // Lista de Tipos
  final List<Stat> stats; // Lista de Estadísticas
  final List<Ability> abilities; // Lista de Habilidades
  
  // REVISAR lo referente a movimientos, quizá no sea necesario
  //final List<Move> moves; // Lista de Movimientos

  PokemonDetail({
    required this.id,
    required this.name,
    required this.weight,
    required this.height,
    required this.isDefault,
    required this.speciesName,
    required this.officialFrontDefaultImg,
    required this.officialFrontShinyImg,
    required this.types,
    required this.stats,
    required this.abilities,
    // required this.moves,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    // Analizando la lista de Tipos
    final List<dynamic> typesData = json['types'];
    final List<Type> types = typesData.map((typeData) {
      return Type.fromJson(typeData);
    }).toList();

    // Analizando la lista de Estadísticas
    final List<dynamic> statsData = json['stats'];
    final List<Stat> stats = statsData.map((statsData) {
      return Stat.fromJson(statsData);
    }).toList();

    // Analizando la lista de Habilidades
    final List<dynamic> abilitiesData = json['abilities'];
    final List<Ability> abilities = abilitiesData.map((abilitiesData) {
      return Ability.fromJson(abilitiesData);
    }).toList();

    // Analizando la lista de Movimientos
    // final List<dynamic> movesData = json['moves'];
    // final List<Move> moves = movesData.map((movesData) {
    //   return Move.fromJson(movesData);
    // }).toList();

    return PokemonDetail(
      id: json['id'] as int,
      name: json['name'] as String,
      weight: json['weight'] as int,
      height: json['height'] as int,
      isDefault: json['is_default'] as bool,
      speciesName: json['species']['name'] as String,
      officialFrontDefaultImg: json['sprites']['other']['official-artwork']['front_default'] as String?,
      officialFrontShinyImg: json['sprites']['other']['official-artwork']['front_shiny'] as String?,
      types: types,
      stats: stats,
      abilities: abilities,
      // moves: moves,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'height': height,
      'is_default': isDefault,
      'species': {'name': speciesName},
      'sprites': {
        'other': {
          'official-artwork': {
            'front_default': officialFrontDefaultImg,
            'front_shiny': officialFrontShinyImg,
          },
        },
      },
      'types': types.map((type) => type.toJson()).toList(),
      'stats': stats.map((stat) => stat.toJson()).toList(),
      'abilities': abilities.map((ability) => ability.toJson()).toList(),
      // 'moves': moves.map((move) => move.toJson()).toList(),
    };
  }
}
