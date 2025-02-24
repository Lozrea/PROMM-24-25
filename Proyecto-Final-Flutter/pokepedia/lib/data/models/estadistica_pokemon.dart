import 'package:pokepedia/core/utils/helpers/format_text_helper.dart';

// Representa una estadística de un Pokémon con su nombre y valor.
class EstadisticaPokemon {
  final String name;
  final int value;

  EstadisticaPokemon({
    required this.name,
    required this.value,
  });

  factory EstadisticaPokemon.fromJson(Map<String, dynamic> json) {
    return EstadisticaPokemon(
      name: FormatTextHelper.formatName(json['stat']['name']),
      value: json['base_stat']
    );
  }
}