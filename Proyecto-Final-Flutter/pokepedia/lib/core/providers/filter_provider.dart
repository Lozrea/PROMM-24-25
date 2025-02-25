import 'package:flutter/foundation.dart';
import 'package:pokepedia/data/models/pokemon_generation.dart';
import 'package:pokepedia/data/models/pokemon_type.dart';
import 'package:pokepedia/core/utils/extensions/list_extension.dart';
import 'package:pokepedia/core/services/pokemon_service.dart';

// Clase que gestiona el estado de los filtros aplicados para la búsqueda y visualización de Pokémon. 
/// Permite filtrar por generaciones, tipos, favoritos y realizar búsquedas por texto. 
/// También gestiona la obtención de datos de filtros desde un servicio de Pokemon.
class FilterProvider with ChangeNotifier {
  // Variables para los filtros
  bool _showFavoritesOnly = false;
  String _searchText = '';
  List<PokemonGeneration> _generations = [];
  List<PokemonType> _types = [];
  List<PokemonType> _selectedTypes = [];
  List<PokemonGeneration> _selectedGenerations = [];

  // Getters para acceder a las propiedades privadas
  List<PokemonGeneration> get selectedGenerations => _selectedGenerations;
  List<PokemonType> get selectedTypes => _selectedTypes;
  bool get showFavoritesOnly => _showFavoritesOnly;

   // Método para obtener los datos de los filtros desde el servicio de Pokémon
  Future<void> fetchFilterData() async {
    // Limpiar las listas de generaciones y tipos seleccionados
    _selectedGenerations.clear();
    _selectedTypes.clear();

    final (result, exception) = await PokemonService.fetchFilters();

    // Manejo de errores si ocurre algún problema al obtener los filtros
    if (exception != null) {
      debugPrint("ERROR fetchFilterData ${exception.toString()}");
      return;
    }

    // Si obtenemos datos, asignamos las generaciones y tipos
    if (result != null) {
      var (generations, types) = result;
      _types = types;
      _generations = generations;
    }

    notifyListeners();
  }

   // Getter y setter para el texto de búsqueda
  String get searchText => _searchText;
  set searchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  // Getters y setters para las generaciones y tipos
  List<PokemonGeneration> get generations => _generations;
  set generations(List<PokemonGeneration> generations) {
    _selectedGenerations = generations;
    notifyListeners();
  }

  List<PokemonType> get types => _types;
  set types(List<PokemonType> types) {
    _selectedTypes = types;
    notifyListeners();
  }

  // Métodos para alternar la selección de generaciones y tipos
  void toggleGenerationSelection(PokemonGeneration generation) {
    _selectedGenerations.toggleElement(generation);
    notifyListeners();
  }

  void toggleTypeSelection(PokemonType type) {
    _selectedTypes.toggleElement(type);
    notifyListeners();
  }

  // Alternar el filtro de favoritos
  void toggleFavoritesOnly() {
    _showFavoritesOnly = !_showFavoritesOnly;
    notifyListeners();
  }

  // Limpiar los filtros de generaciones y tipos
  void clearGenerationFilter() {
    _selectedGenerations.clear();
    notifyListeners();
  }

  void clearTypeFilter() {
    _selectedTypes.clear();
    notifyListeners();
  }

    // Limpiar todos los filtros
  void clearFilters() {
    _searchText = '';
    _selectedGenerations.clear();
    _selectedTypes.clear();
    _showFavoritesOnly = false;
    notifyListeners();
  }
}
