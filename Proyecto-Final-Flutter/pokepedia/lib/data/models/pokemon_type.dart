import 'package:intl/intl.dart';
import 'package:pokepedia/data/models/filter_data.dart';
import 'package:pokepedia/core/utils/enums/pokemon_type.dart';
import 'package:pokepedia/core/utils/enums/pokemon_type_effectiveness.dart';

// Clase que representa un tipo de Pokémon y su efectividad contra otros tipos.
class PokemonType extends FilterData {
  final String type;
  final Map<PokemonTypeEnum, PokemonTypeEffectivenessEnum> effectiveness;

  PokemonType({
    required super.id,
    required String name,
    Map<PokemonTypeEnum, PokemonTypeEffectivenessEnum>? effectiveness,
  }): type = name,
    effectiveness = effectiveness ?? {},
    super(name: toBeginningOfSentenceCase(name));

  // Método de fábrica para crear una instancia de TiposPokemon desde un JSON
  factory PokemonType.fromJson(Map<String, dynamic> json) {
    var type = json['type'];

    return PokemonType(
      id: type['id'] as int,
      name: type['name'] as String,
      effectiveness: _parseEffectiveness(type?['effectiveness']),
    );
  }

  // Método de fábrica para crear un objeto TiposPokemon como filtro
  factory PokemonType.asFilter(Map<String, dynamic> json) {
    return PokemonType(
      id: json['id'] as int,
      name: json['name'] as String,
      effectiveness: null
    );
  }

  // Convierte la lista de efectividades en un mapa de enums
  static Map<PokemonTypeEnum, PokemonTypeEffectivenessEnum> _parseEffectiveness(List? data) {
    if (data == null) return {};

    return {
      for (var item in data)
        PokemonTypeEnum.parse(item['target_type']['name'] as String):
            _mapDamageFactor(item['damage_factor'] as int)
    };
  }

  // Mapea los valores numéricos de daño a un enum de efectividad
  static PokemonTypeEffectivenessEnum _mapDamageFactor(int damageFactor) {
    return switch (damageFactor) {
      < 100 => PokemonTypeEffectivenessEnum.vulnerable, // Menos del 100% significa vulnerabilidad
      > 100 => PokemonTypeEffectivenessEnum.resistant, // Más del 100% significa resistencia
      _ => PokemonTypeEffectivenessEnum.neutral, // 100% es neutral
    };
  }

  @override
  String toString() {
    return 'PokemonType(id: $id, name: $name, type: $type.name)';
  }
}