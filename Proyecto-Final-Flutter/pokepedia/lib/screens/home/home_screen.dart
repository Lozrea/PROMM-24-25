import 'package:flutter/material.dart';
import 'package:pokepedia/core/providers/filter_provider.dart';
import 'package:pokepedia/core/providers/pokemon_provider.dart';
import 'package:pokepedia/screens/widgets_comunes/error_indicator.dart';
import 'package:pokepedia/screens/home/widgets/pokemon_list.dart';
import 'package:pokepedia/screens/home/widgets/pokemon_filters_button.dart';
import 'package:pokepedia/screens/home/widgets/toggle_theme_button.dart';
import 'package:provider/provider.dart';

// Pantalla principal que contiene la lista de Pokémon, los filtros y el tema de la aplicación
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    _fetchPokemons();
  }

  // Método para obtener Pokémon desde el proveedor
  void _fetchPokemons({int page = 0}) {
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);

    final pokemonProvider = Provider.of<PokemonProvider>(context, listen: false);

    pokemonProvider.fetchPokemons(
      generations: filterProvider.selectedGenerations,
      pokemonTypes: filterProvider.selectedTypes,
      searchText: filterProvider.searchText,
      page: page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokepedia'),
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle
          ?? Theme.of(context).textTheme.titleLarge?.copyWith(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontFamily: 'Poppins-Black',
          ),
        actions: const [
          ThemeToggleButton(), // Agrega el botón de cambio de tema
        ],
        actionsIconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Consumer2<FilterProvider, PokemonProvider>(
          builder: (context, filterProvider, pokemonProvider, _) {
            if (pokemonProvider.hasException) {
              return const ErrorIndicator(); // Muestra un mensaje de error si hay una excepción
            }

            final pokemons = filterProvider.showFavoritesOnly
              ? pokemonProvider.favorites // Filtra solo los favoritos si es necesario
              : pokemonProvider.pokemons;

            return PokemonList(
              pokemons: pokemons,
              onEdgeReached: () {
                _fetchPokemons(page: pokemonProvider.currentPage + 1);
              },
              onSearchTextChanged: (String searchText) {
                filterProvider.searchText = searchText;

                _fetchPokemons(page: 0); // Refresca la lista con el nuevo texto de búsqueda
              },
            );
          }
        )
      ),
      floatingActionButton: const PokemonFiltersButton() // Botón flotante de filtros
    );
  }
}