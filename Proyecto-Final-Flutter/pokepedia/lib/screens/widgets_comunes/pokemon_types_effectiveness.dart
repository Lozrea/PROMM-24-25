import 'package:flutter/material.dart';
import 'package:pokepedia/data/models/pokemon_details.dart';
import 'package:pokepedia/core/utils/enums/pokemon_type_effectiveness.dart';
import 'package:pokepedia/screens/detalles_pokemons/widgets/section_title.dart';
import 'package:pokepedia/screens/widgets_comunes/pokemon_type_badge.dart';

// Clase que muestra los iconos de efectividad que tiene un Pokemon
class PokemonTypesEffectiveness extends StatelessWidget {
  final PokemonDetails pokemon;

  const PokemonTypesEffectiveness({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Effectiveness'),
        GridView.count(
          childAspectRatio: 3.5, // Ajusta el aspecto de cada celda en la cuadrícula
          crossAxisCount: 3, // Muestra 3 columnas de efectividad
          crossAxisSpacing: 0, // Sin separación horizontal entre celdas
          mainAxisSpacing: 0, // Sin separación vertical entre celdas
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          primary: false,
          shrinkWrap: true, // Evita que el GridView ocupe más espacio del necesario
          children: pokemon.effectiveness.map((entry) {
            var effectivenessInfo = _getEffectivenessInfo(entry.effectiveness);

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: PokemonTypeBadge(
                    type: entry.type.name
                  )
                ),
                SizedBox(
                  height: 24,
                  width: 24,
                  child: effectivenessInfo.iconData != null
                    ? Icon(
                      effectivenessInfo.iconData,
                      color: effectivenessInfo.color
                    )
                    : null // No muestra nada si no hay un icono asociado
                ),
              ],
            );
          }).toList()
        ),
      ],
    );
  }

  // Método para determinar el icono y color basado en la efectividad del tipo de Pokémon
  static ({IconData? iconData, Color color}) _getEffectivenessInfo(
    PokemonTypeEffectivenessEnum effectiveness
  ) {
    return switch(effectiveness) {
      PokemonTypeEffectivenessEnum.vulnerable => (
        iconData: Icons.keyboard_double_arrow_down_sharp,
        color: Colors.red
      ),
      PokemonTypeEffectivenessEnum.resistant => (
        iconData: Icons.keyboard_double_arrow_up_sharp,
        color: Colors.green
      ),
      _ => (
        iconData: null, // No muestra icono para tipos neutrales
        color: Colors.grey
      )
    };
  }
}