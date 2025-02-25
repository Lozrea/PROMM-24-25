import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pokepedia/data/models/pokemon.dart';
import 'package:pokepedia/screens/home/widgets/filter_chips.dart';
import 'package:pokepedia/screens/widgets_comunes/nothing_found_indicator.dart';
import 'package:pokepedia/screens/widgets_comunes/pokemon_card.dart';

// Widget que muestra una lista de Pokémon con un campo de búsqueda
// y filtros dinámicos que se ajustan según el desplazamiento en la lista.
class PokemonList extends StatefulWidget {
  // Se definen las propiedades que se recibirán al instanciar el widget
  final List<Pokemon> pokemons;
  final bool shrinkWrap; // Controla si la lista debe ajustarse al tamaño de su contenido
  final void Function() onEdgeReached; // Callback cuando se alcanza el borde de la lista
  final void Function(String text) onSearchTextChanged; // Callback para actualizar el texto de búsqueda

  const PokemonList({
    super.key,
    required this.pokemons,
    required this.onEdgeReached,
    required this.onSearchTextChanged,
    this.shrinkWrap = false,
  });

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  final _searchTextController = TextEditingController();  // Controlador del campo de búsqueda
  final _scrollController = ScrollController(); // Controlador del desplazamiento en la lista
  bool _showSearchBar = true; // Controla la visibilidad de la barra de búsqueda
  Timer? _textSearchDebouncer; // Temporizador para retrasar la búsqueda al escribir

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  // Método que maneja el cambio en el desplazamiento y oculta/expone la barra de búsqueda
  void _onScroll() {
    final scrollDirection = _scrollController.position.userScrollDirection;

    if (scrollDirection == ScrollDirection.reverse && _showSearchBar) {
      setState(() => _showSearchBar = false);
    } else if (scrollDirection == ScrollDirection.forward && _showSearchBar == false) {
      setState(() => _showSearchBar = true);
    }
  }

  // Método que actualiza la búsqueda de texto con un retraso para evitar múltiples solicitudes al escribir
  void _onSearchByText(String text) {
    if ((_textSearchDebouncer?.isActive ?? false)) {
      _textSearchDebouncer?.cancel();
    }

    _textSearchDebouncer = Timer(Durations.medium4, () {
      widget.onSearchTextChanged(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
          widget.onEdgeReached(); // Llama a la función de callback cuando se llega al final de la lista
        }

        return false;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Barra de búsqueda animada que se muestra o se oculta
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _showSearchBar ? 86.0 : 0.0,
            child: !_showSearchBar
              ? null
              : Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _searchTextController,
                  decoration: const InputDecoration(
                    hintText: 'Search by name',
                    prefixIcon: Icon(Icons.search),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: _onSearchByText, // Llama al método de búsqueda al cambiar el texto
                  onSubmitted: _onSearchByText, // Llama al método de búsqueda al enviar el texto
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
          ),
          // Filtro de chips de búsqueda si la barra de búsqueda está visible
          if (_showSearchBar) const FilterChips(),
          Expanded(
            child: widget.pokemons.isEmpty
              ? const NothingFoundIndicator() // Muestra un mensaje si no hay Pokémon
              : _buildList() // Si hay Pokémon, se construye la lista
          ),
        ],
      ),
    );
  }

  // Construye la lista de Pokémon usando ListView.builder
  Widget _buildList() {
    return ListView.builder(
      addRepaintBoundaries: true,
      controller: _scrollController,
      padding: const EdgeInsets.only(bottom: 16.0),
      shrinkWrap: widget.shrinkWrap, // Ajusta el tamaño de la lista
      prototypeItem: PokemonCard(pokemon: widget.pokemons.first),
      itemCount: widget.pokemons.length,
      itemBuilder: (context, index) {
        return PokemonCard(pokemon: widget.pokemons[index]);
      }
    );
  }
}