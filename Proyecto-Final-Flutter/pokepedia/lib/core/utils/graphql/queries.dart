// Al usar GraphQL en lugar de API REST que te da la PokeAPI para obtener los datos de los pokemons
// las consultas son más eficientes, evitando el over-fetching (que estaba dando problemas) y mejorando el rendimiento.


// Obtiene información sobre los tipos de pokémons y las generaciones (necesario para lols filtros)
const String fetchFiltersDataQuery = r'''
query GetFiltersData {
  types: pokemon_v2_type {
    id
    name
  }
  generations: pokemon_v2_generation {
    id
    name
  }
}
''';

// Recupera una lista de pokemons con sus respectivos ID, nombre, tipos y sprites
const String fetchPokemonsQuery = r'''
query GetPokemons($where: pokemon_v2_pokemon_bool_exp, $limit: Int, $offset: Int) {
  pokemon: pokemon_v2_pokemon(where: $where, limit: $limit, offset: $offset, order_by: {id: asc}) {
    id
    name
    types: pokemon_v2_pokemontypes {
      type: pokemon_v2_type {
        id
        name
      }
    }
    sprites: pokemon_v2_pokemonsprites {
      front_default: sprites(path: "other.official-artwork.front_default")
    }
  }
}
''';

// Obtiene detalles completos de un Pokémon por su id
const String pokemonDetailQuery = r'''
query GetPokemonDetails($id: Int!) {
  pokemon: pokemon_v2_pokemon_by_pk(id: $id) {
    id
    name
    height
    weight
    base_experience
    types: pokemon_v2_pokemontypes {
      type: pokemon_v2_type {
        id
        name
        effectiveness: pokemonV2TypeefficaciesByTargetTypeId {
          damage_factor
          target_type: pokemon_v2_type {
            id
            name
          }
        }
      }
    }
    abilities: pokemon_v2_pokemonabilities {
      ability: pokemon_v2_ability {
        name
        effects: pokemon_v2_abilityeffecttexts(limit: 1, where: {pokemon_v2_language: {name: {_eq: "en"}}}) {
          effect
        }
        flavor_texts: pokemon_v2_abilityflavortexts(limit: 1, where: {pokemon_v2_language: {name: {_eq: "en"}}}) {
          flavor_text
        }
      }
    }
    stats: pokemon_v2_pokemonstats {
      base_stat
      stat: pokemon_v2_stat {
        name
      }
    }
    moves: pokemon_v2_pokemonmoves_aggregate(where: {pokemon_v2_movelearnmethod: {name: {_eq: "level-up"}}}, distinct_on: move_id, order_by: {}) {
      nodes {
        move: pokemon_v2_move {
          accuracy
          name
          flavor_texts: pokemon_v2_moveflavortexts(limit: 1, where: {pokemon_v2_language: {name: {_eq: "en"}}}) {
            flavor_text
          }
          move_names: pokemon_v2_movenames(limit: 1, where: {pokemon_v2_language: {name: {_eq: "en"}}}) {
            name
          }
          type: pokemon_v2_type {
            name
          }
        }
        level
      }
    }
    species: pokemon_v2_pokemonspecy {
      capture_rate
      shape: pokemon_v2_pokemonshape {
        name
      }
      color: pokemon_v2_pokemoncolor {
        name
      }
      evolves_from_species_id
      flavor_texts: pokemon_v2_pokemonspeciesflavortexts(limit: 1, where: {pokemon_v2_language: {name: {_eq: "en"}}}) {
        flavor_text
      }
      evolution_chain: pokemon_v2_evolutionchain {
        species: pokemon_v2_pokemonspecies {
          name
          pokemons: pokemon_v2_pokemons {
            id
            name
            types: pokemon_v2_pokemontypes {
              type: pokemon_v2_type {
                id
                name
              }
            }
            sprites: pokemon_v2_pokemonsprites {
              front_default: sprites(path: "other.official-artwork.front_default")
            }
          }
          requirements: pokemon_v2_pokemonevolutions {
            min_level
          }
        }
      }
    }
    sprites: pokemon_v2_pokemonsprites {
      front_default: sprites(path: "other.official-artwork.front_default")
    }
  }
}
''';