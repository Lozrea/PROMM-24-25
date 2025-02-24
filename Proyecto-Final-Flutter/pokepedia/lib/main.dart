import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokepedia/data/models/pokemon.dart';
import 'pokepedia_app.dart';
import 'package:pokepedia/core/providers/filter_provider.dart';
import 'package:pokepedia/core/providers/pokemon_provider.dart';
import 'package:pokepedia/core/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp // Restringe la orientación a vertical
  ]);

  final appDir = await getApplicationDocumentsDirectory(); // Obtiene el directorio de documentos de la app

  await Hive.initFlutter(appDir.path); // Inicializa Hive con el directorio de la app

  Hive.registerAdapter(PokemonAdapter()); // Registra el adaptador del modelo Pokémon

  await Hive.openBox<Pokemon>('favorite_pokemons'); // Abre una "caja" para almacenar Pokemon favoritos

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // Proveedor para el tema
        ChangeNotifierProvider(create: (_) => PokemonProvider()), // Proveedor para los datos de Pokémon
        ChangeNotifierProvider(create: (_) => FilterProvider()), // Proveedor para los filtros
      ],
      child: const PokepediaApp()
    ),
  );
}