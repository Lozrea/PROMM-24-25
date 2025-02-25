import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokepedia/data/models/pokemon_details.dart';
import 'package:pokepedia/screens/detalles_pokemons/widgets/section_title.dart';

// Widget que muestra las habilidades de un Pokémon dentro de una lista.
// Toma los detalles del Pokémon (pokemon) y genera una lista de habilidades
class PokemonAbilities extends StatelessWidget {
  final PokemonDetails pokemon;

  const PokemonAbilities({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Abilities'),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pokemon.abilities.length,
          itemBuilder: (context, index) {
            final ability = pokemon.abilities[index];

            return ListTile(
              title: Text(
                toBeginningOfSentenceCase(ability.name),
                style: const TextStyle(fontWeight: FontWeight.bold)
              ),
              subtitle: Text(ability.flavorText)
            );
          }
        )
      ],
    );
  }
}
