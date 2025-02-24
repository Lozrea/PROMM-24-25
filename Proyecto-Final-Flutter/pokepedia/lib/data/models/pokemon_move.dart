import 'package:pokepedia/core/utils/enums/pokemon_type.dart';
import 'package:pokepedia/core/utils/helpers/format_text_helper.dart';

// Representa un movimiento de un Pokémon con sus detalles.
class PokemonMove {
  final String name;
  final String flavorText;
  final int? accuracy;
  final int level;
  final PokemonTypeEnum type;

  PokemonMove({
    required this.name,
    required this.flavorText,
    required this.accuracy,
    required this.level,
    required this.type
  });

  factory PokemonMove.fromJson(Map<String, dynamic> json){
    final move = json['move'];

    return PokemonMove(
      name: FormatTextHelper.formatName(move['name']),
      flavorText: FormatTextHelper.formatFlavorText(move),
      accuracy: move['accuracy'],
      level: json['level'],
      type: PokemonTypeEnum.parse(move['type']['name'])
    );
  }
}