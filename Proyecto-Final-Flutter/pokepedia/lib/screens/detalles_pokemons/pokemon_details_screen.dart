import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pokepedia/screens/detalles_pokemons/widgets/pokemon_header_background.dart';
import 'package:pokepedia/data/models/pokemon.dart';
import 'package:pokepedia/core/providers/theme_provider.dart';
import 'package:pokepedia/core/services/pokemon_service.dart';
import 'package:pokepedia/screens/widgets_comunes/error_indicator.dart';
import 'package:pokepedia/screens/detalles_pokemons/widgets/pokemon_info_tab.dart';
import 'package:pokepedia/screens/detalles_pokemons/widgets/pokemon_evolutions_tab.dart';
import 'package:pokepedia/screens/detalles_pokemons/widgets/pokemon_moves_tab.dart';
import 'package:pokepedia/screens/widgets_comunes/rotating_logo.dart';
import 'package:pokepedia/screens/detalles_pokemons/widgets/toggle_favorite_pokemon_button.dart';
import 'package:provider/provider.dart';

// Pantalla que muestra los detalles de un Pokémon, incluyendo su tipo, movimientos y evoluciones
class PokemonDetailsScreen extends StatelessWidget {
  static const List<Tab> tabs = [
    Tab(text: 'Info'),
    Tab(text: 'Moves'),
    Tab(text: 'Evolutions'),
  ];
  final Pokemon pokemon; // Recibe un objeto Pokemon para mostrar sus detalles

  const PokemonDetailsScreen({
    super.key,
    required this.pokemon
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController( // Controlador para manejar las pestañas
      length: tabs.length,
      child: Scaffold(
        body: NestedScrollView( // Permite que las pestañas tengan un efecto de desplazamiento
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            _renderHeader(context), // Renderiza el encabezado de la pantalla
            _renderTabs(context), // Renderiza las pestañas
          ],
          body: _renderBody() // Contenido de la pantalla
        )
      ),
    );
  }

  Widget _renderHeader(BuildContext context) {
    // Obtiene el proveedor de tema
    final themeProvider = Provider.of<ThemeProvider>(context);

    final headerColor = themeProvider.isDarkMode
      ? hslColor.withLightness(0.25).toColor()  // Color del encabezado según el tema oscuro
      : pokemon.typeColor; // Usa el color del tipo de Pokémon en el tema claro

    // Barra de la aplicación que se desplaza
    return SliverAppBar(
      backgroundColor: headerColor,
      expandedHeight: 300.0,
      floating: false,
      iconTheme: const IconThemeData(color: Colors.white),
      pinned: true, // La barra se mantiene fija al desplazarse
      actions: [
        ToggleFavoritePokemonButton(pokemon: pokemon)  // Botón para marcar como favorito
      ],
      // Espacio flexible que se ajusta con el desplazamiento
      flexibleSpace: FlexibleSpaceBar(
        background: PokemonHeaderBackground(pokemon: pokemon),
        centerTitle: true,
        title: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.85, // Limita el ancho al 85% de la pantalla
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              toBeginningOfSentenceCase(pokemon.name), // Muestra el nombre del Pokémon con formato
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
                overflow: TextOverflow.ellipsis, // Si el texto es largo, se corta
                shadows: [
                  const Shadow(
                    blurRadius: 10,
                    color: Colors.black87,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              )
            ),
          ),
        )
      ),
    );
  }

  Widget _renderTabs(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final tabsColor = themeProvider.isDarkMode
      ? hslColor.withLightness(0.6).toColor()
      : hslColor.withLightness(0.4).toColor();

    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverTabBarDelegate(
        TabBar(
          dividerHeight: 1,
          dividerColor: themeProvider.isDarkMode
            ? Colors.grey.shade600
            : Colors.grey.shade200,
          indicator: ShapeDecoration(
            shape: const RoundedRectangleBorder(),
            image: DecorationImage(
              image: const AssetImage("assets/images/pokeball-tabs-background.png"),
              opacity: 0.2,
              colorFilter: ColorFilter.mode(pokemon.typeColor, BlendMode.srcIn)
            ),
          ),
          indicatorColor: tabsColor,
          indicatorPadding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3.0,
          labelColor: tabsColor,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            shadows: [
              Shadow(
                blurRadius: 1,
                color: Colors.white12,
                offset: Offset(0, 0),
              )
            ]
          ),
          unselectedLabelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.normal,
            fontSize: 16
          ),
          tabs: tabs,
        ),
      ),
    );
  }

  Widget _renderBody() {
    return FutureBuilder<PokemonDetailsResponse>(
      future: PokemonService.fetchDetails(pokemon.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _BackgroundBox(
            child: Opacity(
              opacity: 0.3,
              child: RotatingLogo(
                duration: Durations.extralong4,
              )
            )
          );
        }

        if (snapshot.hasError && snapshot.data == null) {
          return _renderErrorAlert();
        }

        var (pokemonDetails, exception) = snapshot.data!;

        if (exception != null || pokemonDetails == null) {
          return _renderErrorAlert();
        }

        return ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: TabBarView(
            children: [
              PokemonInfoTab(pokemon: pokemonDetails),
              PokemonMovesTab(pokemon: pokemonDetails),
              PokemonEvolutionsTab(pokemon: pokemonDetails)
            ],
          ),
        );
      }
    );
  }

  Widget _renderErrorAlert() {
    return const _BackgroundBox(
      child: ErrorIndicator()
    );
  }

  HSLColor get hslColor {
    return HSLColor.fromColor(pokemon.typeColor);
  }
}

class _BackgroundBox extends StatelessWidget {
  final Widget child;

  const _BackgroundBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: child
      )
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate(this.tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar
    );
  }

  double get preferredSize => tabBar.preferredSize.height;

  @override
  double get maxExtent => preferredSize;

  @override
  double get minExtent => preferredSize;

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return oldDelegate.tabBar != tabBar;
  }
}