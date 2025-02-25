import 'package:flutter/material.dart';
import '../screens/screens.dart';


class AppRoutes {
  // Nombres de rutas
  static const String home = "/";

  // Mapas de rutas
  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen()
    // TO DO: Añadir el resto de rutas
  };
}