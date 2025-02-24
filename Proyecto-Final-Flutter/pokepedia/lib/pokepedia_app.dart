import 'package:flutter/material.dart';
import 'package:pokepedia/core/providers/filter_provider.dart';
import 'package:pokepedia/core/providers/theme_provider.dart';
import 'package:pokepedia/screens/home/home_screen.dart';
import 'package:pokepedia/core/utils/helpers/pokemon_types_helper.dart';
import 'package:pokepedia/core/theme/theme.dart';
import 'package:provider/provider.dart';

class PokepediaApp extends StatefulWidget {
  const PokepediaApp({super.key});

  @override
  State<PokepediaApp> createState() => _PokepediaAppAppState();
}

class _PokepediaAppAppState extends State<PokepediaApp> {
  @override
  initState() {
    // Se cargan los datos de los filtros y el tema de la aplicación
    Provider.of<FilterProvider>(context, listen: false).fetchFilterData();
    Provider.of<ThemeProvider>(context, listen: false).loadTheme();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la bandera de "debug"
      showPerformanceOverlay: false, // No muestra la superposición de rendimiento
      title: 'Pokepedia',
      themeMode: themeProvider.mode, // Usa el modo de tema definido en el proveedor
      darkTheme: PokepediaAppTheme.darkTheme,
      theme: PokepediaAppTheme.lightTheme,
      builder: (context, widget) {
        PokemonTypesHelper.precacheTypeImages(context);

        return widget ?? const SizedBox.shrink();
      },
      home: const HomeScreen(),
    );
  }
}
