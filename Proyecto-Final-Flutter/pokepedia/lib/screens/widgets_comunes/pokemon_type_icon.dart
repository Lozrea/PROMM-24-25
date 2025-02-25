import 'package:flutter/material.dart';
import 'package:pokepedia/core/utils/enums/pokemon_type.dart';

// Widget que hereda de Image y usa una ruta de imagen basada en el nombre del tipo de Pokémon.
// Esto hace que la clase sea reutilizable sin necesidad de definir rutas manualmente.
class PokemonTypeImage extends Image {
  final PokemonTypeEnum type;

  PokemonTypeImage(this.type, {
    super.key,
    super.bundle,
    super.frameBuilder,
    super.errorBuilder,
    super.semanticLabel,
    super.excludeFromSemantics,
    super.scale,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.colorBlendMode,
    super.fit,
    super.alignment,
    super.repeat,
    super.centerSlice,
    super.matchTextDirection,
    super.gaplessPlayback,
    super.isAntiAlias,
    super.package,
    super.filterQuality,
    super.cacheWidth,
    super.cacheHeight
  }): super.asset('assets/images/pokemon_types/icons/${type.name}.png');
}
