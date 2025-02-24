import 'package:pokepedia/core/utils/helpers/format_text_helper.dart';

// Clase que representa una habilidad de un Pokémon
class HabilidadPokemon {
  final String name;
  final String flavorText;
  final String effect;

  HabilidadPokemon({
    required this.name,
    required this.flavorText,
    required this.effect,
  });

  factory HabilidadPokemon.fromJson(Map<String, dynamic> json) {
    final ability = json['ability'];

    return HabilidadPokemon (
      name: FormatTextHelper.formatName(ability['name']),
      flavorText: FormatTextHelper.formatFlavorText(ability),
      effect: FormatTextHelper.formatFlavorText(
        ability,
        collection: 'effects',
        key: 'effect'
      )
    );
  }

  @override
  String toString() {
    return name;
  }
}