import 'package:flutter/material.dart';
import 'package:pokepedia/data/models/pokemon.dart';
import 'package:pokepedia/core/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

// Clase para el botón de "Favoritos", es decir, cuando marcamos un Pokemon como favorito
class ToggleFavoritePokemonButton extends StatelessWidget {
  final Pokemon pokemon;

  const ToggleFavoritePokemonButton({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) => Consumer<PokemonProvider>(
    builder: (context, pokemonProvider, _) {
      return IconButton(
        iconSize: 20,
        padding: EdgeInsets.zero,
        icon: Icon(
          pokemon.isFavorite ? Icons.favorite : Icons.favorite_border,
        ),
        onPressed: () {
          pokemonProvider.toggleFavorite(pokemon);
        },
      );
    },
  );
}