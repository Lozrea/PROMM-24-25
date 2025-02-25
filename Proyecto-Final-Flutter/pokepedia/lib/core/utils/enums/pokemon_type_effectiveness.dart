enum PokemonTypeEffectivenessEnum {
  resistant, // Resistente a un tipo de ataque
  neutral, // Eficacia neutral
  vulnerable; // Vulnerable a un tipo de ataque

  // Método para analizar la eficacia de un tipo según un puntaje
  static PokemonTypeEffectivenessEnum parse(int score) {
    return switch (score) {
      > 0 => PokemonTypeEffectivenessEnum.resistant,
      < 0 => PokemonTypeEffectivenessEnum.vulnerable,
      _ => PokemonTypeEffectivenessEnum.neutral
    };
  }
}

extension PokemonTypeEffectivenessEnumExtension on PokemonTypeEffectivenessEnum {
  // Obtener el puntaje asociado a cada tipo de eficacia
  int get score {
    return switch (this) {
      PokemonTypeEffectivenessEnum.resistant => 1,
      PokemonTypeEffectivenessEnum.neutral => 0,
      PokemonTypeEffectivenessEnum.vulnerable => -1
    };
  }
}