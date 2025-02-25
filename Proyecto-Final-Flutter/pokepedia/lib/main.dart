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

// Esta función main es el punto de entrada de la aplicación. Configura la inicialización de la aplicación
// y gestiona configuraciones previas como la restricción de la orientación y la inicialización de bases de datos.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp // Restringe la orientación a vertical
  ]);

  final appDir = await getApplicationDocumentsDirectory(); // Obtiene el directorio de documentos para la app

  await Hive.initFlutter(appDir.path); // Inicializa Hive con la ruta del directorio de documentos de la app

  Hive.registerAdapter(PokemonAdapter()); // Registra el adaptador necesario para almacenar objetos de tipo Pokemon en Hive

  await Hive.openBox<Pokemon>('favorite_pokemons'); // Abre una "caja" para almacenar Pokemon favoritos

  runApp(
    // Se utiliza MultiProvider para gestionar el estado de múltiples proveedores
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