import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:pokepedia/core/providers/filter_provider.dart';
import 'package:pokepedia/core/providers/pokemon_provider.dart';
import 'package:pokepedia/core/utils/enums/pokemon_type.dart';
import 'package:pokepedia/data/models/pokemon_generation.dart';
import 'package:pokepedia/data/models/pokemon_type.dart';
import 'package:pokepedia/screens/widgets_comunes/pokemon_type_icon.dart';
import 'package:provider/provider.dart';

// Botón flotante que permite activar los filtros de Pokémon
class PokemonFiltersButton extends StatefulWidget {
  const PokemonFiltersButton({super.key});

  @override
  State<PokemonFiltersButton> createState() => _PokemonFiltersButtonState();
}

class _PokemonFiltersButtonState extends State<PokemonFiltersButton> {
  Timer? _generationsFilterDebouncer; // Temporizador para los filtros de generación
  Timer? _typesFilterDebouncer; // Temporizador para los filtros de tipo

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(
      builder: (context, filterProvider, _) {
        // Botón flotante con un icono de menú
        return SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          tooltip: 'Filters', // Tooltip cuando el usuario pasa el cursor sobre el botón
          children: [
            // Opciones de filtros que se despliegan
            _buildSpeedDialChild(
              child: const Icon(Icons.onetwothree_rounded),
              label: 'Generations',
              onTap: () => _openGenerationFilter(context)
            ),
            _buildSpeedDialChild(
              child: const Icon(Icons.energy_savings_leaf_sharp),
              label: 'Types',
              onTap: () => _openTypeFilter(context)
            ),
            _buildSpeedDialChild(
              child: Icon(
                filterProvider.showFavoritesOnly ? Icons.list : Icons.favorite
              ),
              label: filterProvider.showFavoritesOnly ? 'Show all' : 'Show favorites',
              onTap: () => filterProvider.toggleFavoritesOnly()
            ),
          ],
        );
      }
    );
  }

  SpeedDialChild _buildSpeedDialChild({
    required String label,
    required void Function() onTap,
    Widget? child,
  }) {
    return SpeedDialChild(
      backgroundColor: Theme.of(context).primaryColor,
      child: child,
      foregroundColor: Colors.white,
      label: label,
      labelBackgroundColor: Colors.black,
      labelShadow: [],
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold
      ),
      onTap: onTap,
      shape: const CircleBorder()
    );
  }

  void _openGenerationFilter(BuildContext context) {
    showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 400),
      context: context,
      isDismissible: true,
      builder: (context) {
        final filterProvider = Provider.of<FilterProvider>(context);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              _BottomSheetHeader(
                onClearFilter: () {
                  filterProvider.clearGenerationFilter();

                  _fetchPokemonsList();
                },
                title: 'Pokemon Generations',
              ),
              SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 3,
                ),
                itemCount: filterProvider.generations.length,
                itemBuilder: (context, index) {
                  final generation = filterProvider.generations[index];

                  return FilterChip(
                    elevation: 1,
                    showCheckmark: false,
                    padding: EdgeInsets.zero,
                    selected: filterProvider.selectedGenerations.contains(generation),
                    label: Center(
                      child: Text(generation.name),
                    ),
                    onSelected: (_) => _toggleGenerationSelection(generation)
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _fetchPokemonsList() {
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);

    Provider.of<PokemonProvider>(context, listen: false)
      .fetchPokemons(
        generations: filterProvider.selectedGenerations,
        pokemonTypes: filterProvider.selectedTypes,
        searchText: filterProvider.searchText,
        page: 0
      );
  }

  void _toggleGenerationSelection(PokemonGeneration generation) {
    Provider.of<FilterProvider>(context, listen: false)
      .toggleGenerationSelection(generation);

    if ((_generationsFilterDebouncer?.isActive ?? false)) {
      _generationsFilterDebouncer?.cancel();
    }

    _generationsFilterDebouncer = Timer(Durations.long4, () {
      _fetchPokemonsList();
    });
  }

  void _openTypeFilter(BuildContext context) {
    showModalBottomSheet(
      constraints: const BoxConstraints(maxHeight: 400),
      context: context,
      isDismissible: true,
      builder: (context) {
        final filterProvider = Provider.of<FilterProvider>(context);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              _BottomSheetHeader(
                onClearFilter: () {
                  filterProvider.clearTypeFilter();

                  _fetchPokemonsList();
                },
                title: 'Pokemon Types',
              ),
              SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.3,
                ),
                itemCount: filterProvider.types.length,
                itemBuilder: (context, index) {
                  final pokemonType = filterProvider.types[index];

                  return FilterChip(
                    showCheckmark: false,
                    padding: const EdgeInsets.all(8),
                    selected: filterProvider.selectedTypes.contains(pokemonType),
                    label: Center(
                      child: Column(
                        children: [
                          PokemonTypeImage(
                            PokemonTypeEnum.parse(pokemonType.type),
                            height: 30,
                            width: 30
                          ),
                          Text(pokemonType.name)
                        ],
                      ),
                    ),
                    onSelected: (_) => _toggleTypeSelection(pokemonType)
                  );
                }
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleTypeSelection(PokemonType type) {
    Provider.of<FilterProvider>(context, listen: false)
      .toggleTypeSelection(type);

    if ((_typesFilterDebouncer?.isActive ?? false)) {
      _typesFilterDebouncer?.cancel();
    }

    _typesFilterDebouncer = Timer(Durations.long4, () {
      _fetchPokemonsList();
    });
  }
}

class _BottomSheetHeader extends StatelessWidget {
  final void Function() onClearFilter;
  final String title;

  const _BottomSheetHeader({
    required this.onClearFilter,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return SliverAppBar(
      actions: [
        TextButton(
          onPressed: onClearFilter,
          child: const Text("Clear"),
        )
      ],
      backgroundColor: themeData.bottomSheetTheme.backgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        collapseMode: CollapseMode.pin,
        title: Text(
          title,
          style: themeData.textTheme.titleMedium
        ),
      ),
      foregroundColor: themeData.textTheme.titleMedium!.color,
      pinned: true,
    );
  }
}
