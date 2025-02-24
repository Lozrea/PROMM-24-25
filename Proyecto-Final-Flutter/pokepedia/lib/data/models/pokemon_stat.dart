import 'package:pokepedia/core/utils/helpers/format_text_helper.dart';

// Representa una estadística de un Pokémon con su nombre y valor.
class PokemonStat {
  final String name;
  final int value;

  PokemonStat({
    required this.name,
    required this.value,
  });

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    return PokemonStat(
      name: FormatTextHelper.formatName(json['stat']['name']),
      value: json['base_stat']
    );
  }
}