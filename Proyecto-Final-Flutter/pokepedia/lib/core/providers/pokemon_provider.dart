import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pokepedia/data/models/pokemon_generation.dart';
import 'package:pokepedia/data/models/pokemon.dart';
import 'package:pokepedia/data/models/pokemon_type.dart';
import 'package:pokepedia/core/services/pokemon_service.dart';

// Clase que gestiona el estado de los Pokemon mostrados en la aplicación. 
/// Se encarga de cargar la lista de Pokemon, gestionar los favoritos, 
/// y realizar peticiones al servicio para obtener los datos de los Pokemon.
class PokemonProvider with ChangeNotifier {
   // Variables para gestionar los Pokémon
  final List<Pokemon> _pokemons = [];
  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasException = false;
  final Box<Pokemon> _favoritesBox = Hive.box<Pokemon>('favorite_pokemons');

  // Getters
  List<Pokemon> get favorites => _favoritesBox.values.toList();
  bool get hasException => _hasException;
  bool get isLoading => _isLoading;
  int get currentPage => _currentPage;
  List<Pokemon> get pokemons => _pokemons;

  /// Método que obtiene una lista de Pokémon según los filtros proporcionados.
  /// Realiza la búsqueda de Pokémon a partir de los filtros de generación, tipo y texto.
  Future<void> fetchPokemons({
    required List<PokemonGeneration> generations,
    required List<PokemonType> pokemonTypes,
    String? searchText,
    int? page,
  }) async {
    if (page != null) {
      _currentPage = page;
    }

     // Si es la primera página, limpiamos la lista de Pokémon
    if (page == 0) {
      _pokemons.clear();
    }

    final Map<String, dynamic> where = {};

    // Filtrar por generaciones seleccionadas
    if (generations.isNotEmpty) {
      var generationIds = generations.map((item) => item.id).toList();
      where['pokemon_v2_pokemonspecy'] = {
        'generation_id': {'_in': generationIds},
      };
    }

    // Filtrar por tipos seleccionados
    if (pokemonTypes.isNotEmpty) {
      var types = pokemonTypes.map((item) => item.type).toList();
      where['pokemon_v2_pokemontypes'] = {
        'pokemon_v2_type': {'name': {'_in': types}}
      };
    }

    // Filtrar por nombre de Pokémon si hay texto de búsqueda
    if (searchText != null && searchText.isNotEmpty) {
      where['name'] = {
        '_regex': searchText.toLowerCase()
      };
    }

    const int limitPerPage = 15;

    // Establecer que se está cargando
    _isLoading = true;

    // Obtener los resultados de los Pokemon
    final (result, exception) = await PokemonService.fetchList(
      limit: limitPerPage,
      offset: limitPerPage * _currentPage,
      where: where,
    );

    // Finalizar el estado de carga
    _isLoading = false;
    _hasException = exception != null;

    // Agregar los resultados a la lista de Pokémon
    _pokemons.addAll(result ?? []);

    notifyListeners();
  }

  /// Método que alterna el estado de favorito de un Pokémon. 
  /// Si el Pokémon es marcado como favorito, se guarda en la base de datos (Hive),
  /// y si es desmarcado, se elimina de la base de datos.
  void toggleFavorite(Pokemon pokemon) {
    pokemon.isFavorite = !pokemon.isFavorite;

    if (pokemon.isFavorite) {
      _favoritesBox.put(pokemon.id, pokemon);
    } else {
      _favoritesBox.delete(pokemon.id);
    }

    notifyListeners();
  }
}
