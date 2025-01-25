import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokepedia/models/pokemon_movimiento.dart';

import 'package:pokepedia/models/pokemon_detail.dart';
import 'package:pokepedia/models/pokemon.dart';
import 'package:pokepedia/models/pokemon_list.dart';
import 'package:pokepedia/database/pokemon_db.dart';


class ApiService {
  // Fetch(Obtener) una lista con paginación. Para cambiar cantidad de paginacion, modificar limit=
  static Future<void> fetchData(void Function(PokemonList, List<PokemonDetail>) updateState) async {
    final response = await http.get(
        Uri.parse("https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20") // Tiramos de la API
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final pokemonList = PokemonList.fromJson(data);
      final newPokemonDetails = await fetchPokemonDetailsForList(pokemonList.results);

      // Insertando PokemonList en la base de datos
      await PokemonDB.insertPokemonList(pokemonList);
      // Usando Batch para insertar detalles a la base de datos.
      await PokemonDB.insertPokemonDetails(newPokemonDetails);

      updateState(pokemonList, newPokemonDetails);
    } else {
      throw Exception('Failed to load Pokémon list');
    }
  }
  // Fetch para detalles de pokemons dentro de paginación
  static Future<List<PokemonDetail>> fetchPokemonDetailsForList(List<Pokemon> pokemonList) async {
    final List<Future<PokemonDetail>> futures = [];

    for (var pokemon in pokemonList) {
      futures.add(fetchPokemon(pokemon.url));
    }

    return await Future.wait(futures);
  }
  // Fetch para pokemon específico mediante URL
  static Future<PokemonDetail> fetchPokemon(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return PokemonDetail.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }

  // Fetch para el siguiente conjunto de pokemons en paginación infinita.
  static Future<void> fetchMoreData(String next, void Function(PokemonList, List<PokemonDetail>) updateState) async {
    final response = await http.get(Uri.parse(next));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final newPokemonList = PokemonList.fromJson(data);
      final newPokemonDetails = await fetchPokemonDetailsForList(newPokemonList.results);

      // Insertando PokemonList en la base de datos
      await PokemonDB.insertPokemonList(newPokemonList);
      // Usando Batch para insertar detalles a la base de datos.
      await PokemonDB.insertPokemonDetails(newPokemonDetails);

      updateState(newPokemonList, newPokemonDetails);
    } else {
      throw Exception('Failed to load more Pokémons');
    }
  }

  // Fetch para detalle de Pokemon por su ID
  static Future<PokemonDetail> fetchPokemonDetailById(int pokemonId) async {
    final String url = 'https://pokeapi.co/api/v2/pokemon/$pokemonId/'; // Tiramos de la API por ID de pokemons
    final Future<PokemonDetail> pokemon = fetchPokemon(url);

    return pokemon;
  }

  static Future<void> fetchPokemonSearch(String identifier, void Function(List<PokemonDetail>) updateState, BuildContext context,) async {
    try {
      final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$identifier/')); // Tiramos de la API para buscar un pokemon por su ID

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final pokemonDetail = PokemonDetail.fromJson(data);
        updateState([pokemonDetail]);
      } else {
        throw Exception('Failed to load Pokémon');
      }
    } catch (e) {
      updateState([]); // Actualizamos el estado con una lista vacía
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se ha encontrado este Pokemon.')),
      );
    }
  }

  /// ////////////////////////////////////// GALERIA ////////////////////////////////////////
  /// SI DIESE TIEMPO AQUÍ IRÍA LA GALERÍA, TIRANDO DE LA API
  /// ///////////////////////////////////////////////////////////////////////////////////////

  // Fetch para Pokemon con ID generado aleatoriamente al llamar la a función
  static Future<PokemonDetail> fetchRandomPokemonDetail() async {
    final randomId = Random().nextInt(1016) + 1;
    final String url = 'https://pokeapi.co/api/v2/pokemon/$randomId/';
    final Future<PokemonDetail> pokemon = fetchPokemon(url);

    return pokemon;
  }

  static Future<List<PokemonDetail>> fetchEvoluciones(String nombrePokemon) async {
    final response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/$nombrePokemon")); // Tiramos de la API por el nombre de pokemons para las evoluciones

    if (response.statusCode == 200) {
      final datosPokemon = json.decode(response.body);
      final especieUrl = datosPokemon["species"]["url"];

      final especieResponse = await http.get(Uri.parse(especieUrl));
      if (especieResponse.statusCode == 200) {
        final datosEspecie = json.decode(especieResponse.body);
        final cadenaEvolucionUrl = datosEspecie["evolution_chain"]["url"];

        final cadenaEvolucionResponse = await http.get(Uri.parse(cadenaEvolucionUrl));
        if (cadenaEvolucionResponse.statusCode == 200) {
          final datosCadenaEvolucion = json.decode(cadenaEvolucionResponse.body);
          final cadenaEvolucion = await getPokemonDetailsFromChain(datosCadenaEvolucion, nombrePokemon);
          return cadenaEvolucion;
        } else {
          debugPrint("No se pudo obtener la cadena de evolución.");
          return [];
        }
      } else {
        debugPrint("No se pudo obtener la información de la especie.");
        return [];
      }
    } else {
      debugPrint("No se pudo obtener la información del Pokémon.");
      return [];
    }
  }

  static Future<List<PokemonDetail>> getPokemonDetailsFromChain(Map<String, dynamic> datosCadenaEvolucion, String nombrePokemon) async {
    final List<PokemonDetail> cadenaEvolucion = [];

    Future<void> procesarEspecie(Map<String, dynamic> especie) async {
      final nombreEspecie = especie["species"]["name"];
      if (nombreEspecie != nombrePokemon) {
        final PokemonDetail pokemonDetail = await fetchPokemon("https://pokeapi.co/api/v2/pokemon/$nombreEspecie");
        cadenaEvolucion.add(pokemonDetail);
      }

      if (especie["evolves_to"] != null) {
        for (final evolucion in especie["evolves_to"]) {
          await procesarEspecie(evolucion);
        }
      }
    }

    final especieInicial = datosCadenaEvolucion["chain"];
    await procesarEspecie(especieInicial);

    return cadenaEvolucion;
  }


  static Future<String> fetchMoveDescription(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> flavorTextEntries = data['flavor_text_entries'];

      // Find the first flavor text entry with language "en"
      final englishFlavorTextEntry = flavorTextEntries.firstWhere(
            (entry) => entry['language']['name'] == 'en',
        orElse: () => null,
      );

      if (englishFlavorTextEntry != null) {
        return englishFlavorTextEntry['flavor_text'];
      }
    }

    // Si no se encuentra una entrada válida o el código de respuesta no es 200, devuelve un valor predeterminado
    return 'No Description';
  }


  static Future<List<Move>> fetchMovesByPokemonId(int pokemonId) async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonId/')); // Tiramos de la API por el ID de un pokemon para saber sus movimientos

    if (response.statusCode == 200) {
      final Map<String, dynamic> pokemonData = json.decode(response.body);
      final List<dynamic> movesData = pokemonData['moves'];

      List<Move> moves = movesData.map((move) => Move.fromJson(move)).toList();
      return moves;
    } else {
      throw Exception('Failed to load moves');
    }
  }

  static Future<void> fetchSampleDataToDB() async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/?offset=0&limit=300'); // Limitamos el número de pokemons que se pueden obtener a 300 max

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final PokemonList pokemonList = PokemonList.fromJson(data);
        final List<PokemonDetail> newPokemonDetails = await ApiService.fetchPokemonDetailsForList(pokemonList.results);

        await PokemonDB.insertPokemonList(pokemonList);
        await PokemonDB.insertPokemonDetails(newPokemonDetails);

      } else {
        debugPrint('Failed to fetch sample data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error during sample data fetch: $e');
    }
  }


}