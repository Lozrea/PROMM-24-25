import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokepedia/data/models/pokemon_generation.dart';
import 'package:pokepedia/data/models/pokemon.dart';
import 'package:pokepedia/data/models/pokemon_details.dart';
import 'package:pokepedia/data/models/pokemon_type.dart';
import 'package:pokepedia/core/utils/graphql/queries.dart';

// Clase que obtiene la conexión con la API mediante GraphQL
typedef _Response<T extends Object> = (T? result, Exception? exception);

typedef GqlResponse = _Response<QueryResult>;

typedef PokemonDetailsResponse = _Response<PokemonDetails>;

typedef PokemonListResponse = _Response<List<Pokemon>>;

typedef PokemonFiltersResponse = _Response<(
  List<PokemonGeneration> generations,
  List<PokemonType> types
)>;

// Se configura el cliente con el endpoint GraphQL de PokeAPI
class PokemonService {
  static final _graphQlClient = GraphQLClient(
    link: HttpLink('https://beta.pokeapi.co/graphql/v1beta'),
    cache: GraphQLCache(),
  );

  // Este método ejecuta cualquier consulta GraphQL y maneja errores
  static Future<GqlResponse> _executeQuery(QueryOptions queryOptions) async {
    try {
      final result = await _graphQlClient.query(queryOptions);

      if (result.hasException) {
        throw Exception(result.exception);
      }

      return (result, null);
    } on Exception catch (error) {
      return (null, error);
    }
  }

  // Ejecuta la consulta pokemonDetailQuery para obtener información detallada de un pokemon específico
  static Future<PokemonDetailsResponse> fetchDetails(int id) async {
    var response = await _executeQuery(QueryOptions(
      document: gql(pokemonDetailQuery),
      variables: {'id': id},
    ));

    var (result, exception) = response;

    if (exception != null) {
      return (null, exception);
    }

    if (result?.data == null || result?.data?['pokemon'] == null) {
      return (null, Exception('Empty pokemon data'));
    }

    return (PokemonDetails.fromJson(result!.data!['pokemon']), exception);
  }

  // Obtiene los tipos y generaciones de pokemon para usarlos como filtros en la app
  static Future<PokemonFiltersResponse> fetchFilters() async {
    var response = await _executeQuery(QueryOptions(
      document: gql(fetchFiltersDataQuery)
    ));

    var (result, exception) = response;

    if (exception != null) {
      return (null, exception);
    }

    if (result?.data?['types'] == null) {
      return (null, Exception('Empty pokemon type filters'));
    }

    if (result?.data?['generations'] == null) {
      return (null, Exception('Empty pokemon generation filters'));
    }

    List<PokemonType> types = (result?.data?['types'] as List)
      .map((data) => PokemonType.asFilter(data))
      .toList();

    List<PokemonGeneration> generations = (result?.data?['generations'] as List)
      .map((data) => PokemonGeneration.fromJson(data))
      .toList();

    return ((generations, types), null);
  }

  // Obtiene una lista de pkemon con opciones de paginación y filtros personalizados
  static Future<PokemonListResponse> fetchList({
    required int limit,
    required int offset,
    Map<String, dynamic>? where,
  }) async {
    var response = await _executeQuery(QueryOptions(
      document: gql(fetchPokemonsQuery),
      variables: {
        'where': where == null || where.isEmpty ? null : where,
        'limit': limit,
        'offset': offset,
      }
    ));

    var (result, exception) = response;

    if (exception != null) {
      return (null, exception);
    }

    if (result?.data?['pokemon'] == null) {
      return (null, Exception('Empty pokemon list'));
    }

    var pokemons = (result!.data!['pokemon'] as List)
      .map((data) => Pokemon.fromJson(data))
      .toList();

    return (pokemons, null);
  }
}