import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokepedia/data/models/pokemon.dart';
import 'package:pokepedia/core/providers/theme_provider.dart';
import 'package:pokepedia/screens/detalles_pokemons/pokemon_details_screen.dart';
import 'package:pokepedia/core/utils/helpers/pokemon_types_helper.dart';
import 'package:pokepedia/screens/widgets_comunes/pokemon_sprite.dart';
import 'package:pokepedia/screens/widgets_comunes/pokemon_types.dart';
import 'package:provider/provider.dart';

// Widget que representa la tarjeta de un Pokémon en la interfaz de usuario. 
// Al hacer clic en la tarjeta, se navega a la pantalla de detalles del Pokémon seleccionado.
class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Navegar a la pantalla de detalles cuando se toca la tarjeta
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetailsScreen(pokemon: pokemon)
          ),
        );
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  opacity: 0.15,
                  image: AssetImage(PokemonTypesHelper.getTypeBackground(pokemon.mainType.type))
                ),
                color: pokemon.typeColor,
                gradient: _getBackgroundGradient(context),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getPokemonIdBadge(context), // Muestra el ID del Pokémon
                        _getPokemonName(context),     // Muestra el nombre del Pokémon
                        PokemonTypes(pokemon: pokemon) // Muestra los tipos del Pokémon
                      ],
                    ),
                    PokemonSprite(
                      size: 128,
                      pokemon: pokemon, // Muestra el sprite del Pokémon
                    )
                  ],
                )
              ),
            ),
          )
        ]
      ),
    );
  }

  // Muestra el nombre del Pokémon con el formato adecuado y la sombra si es modo oscuro
  Widget _getPokemonName(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.5,
        ),
        child: Text(
          toBeginningOfSentenceCase(pokemon.name), // Formatea el nombre
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
            shadows: isDarkMode ? [
              const Shadow(
                blurRadius: 1,
                color: Colors.black87,
                offset: Offset(1.0, 1.0),
              )
            ] : null,
          ),
        ),
      ),
    );
  }

  // Muestra el ID del Pokémon con un fondo decorado
  Widget _getPokemonIdBadge(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    var hslColor = HSLColor.fromColor(pokemon.typeColor);

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isDarkMode
            ? hslColor.withLightness(0.2).toColor()
            : hslColor.withLightness(0.45).toColor(),
          borderRadius: BorderRadius.circular(16)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0
          ),
          child: Text(
            "#${pokemon.id}",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                const Shadow(
                  blurRadius: 5,
                  color: Colors.black87,
                  offset: Offset(1.0, 1.0),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  // Devuelve un gradiente de fondo en función del modo oscuro o claro
  LinearGradient _getBackgroundGradient(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return LinearGradient(
      begin: AlignmentDirectional.topCenter,
      end: AlignmentDirectional.bottomEnd,
      colors: _getBackgroundGradientColors(isDarkMode)
    );
  }

  // Define los colores del gradiente según el modo oscuro o claro
  List<Color> _getBackgroundGradientColors(bool isDarkMode) {
    var hslColor = HSLColor.fromColor(pokemon.typeColor);

    if (isDarkMode) {
      return [
        hslColor.withLightness(0.1).toColor(),
        hslColor.withLightness(0.2).toColor(),
        hslColor.withLightness(0.3).toColor(),
      ];
    }

    return [
      hslColor.withLightness(0.7).toColor(),
      hslColor.withLightness(0.6).toColor(),
      hslColor.withLightness(0.5).toColor(),
    ];
  }
}