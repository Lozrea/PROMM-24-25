import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pokepedia/data/models/pokemon_type.dart';
import 'package:pokepedia/core/utils/helpers/pokemon_types_helper.dart';

part 'pokemon.g.dart';

// Clase que representa un pokemon con sus características básicas
@HiveType(typeId: 1)
class Pokemon {
  @HiveField(0)
  final int id; // Identificador único del pokémon

  @HiveField(1)
  final String name; // Nombre del pokémon

  @HiveField(2)
  final List<TiposPokemon> types; // Lista de tipos que tiene el pokémon

  @HiveField(3)
  final String sprite; // URL del sprite del pokémon

  @HiveField(4)
  bool isFavorite; // Indica si el pokémon está marcado como favorito

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.sprite,
    this.isFavorite = false, // Por defecto, no es favorito
  });

  // Método de fábrica para crear un pokémon desde un JSON
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final types = (json['types'] as List)
      .map((data) => TiposPokemon.fromJson(data))
      .toList();

    return Pokemon(
      id: json['id'],
      name: json['name'],
      types: types,
      sprite: json['sprites'][0]['front_default'] ?? ''
    );
  }

  // Obtiene el tipo principal del pokémon (el primero en la lista)
  TiposPokemon get mainType {
    return types.first;
  }

  // Obtiene el color representativo del tipo principal del pokémon
  Color get typeColor {
    return PokemonTypesHelper.getTypeColor(mainType.name);
  }
}