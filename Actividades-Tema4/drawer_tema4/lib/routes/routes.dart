// Ruta: lib/routes/routes.dart
import 'package:drawer_tema4/main.dart';
import 'package:flutter/material.dart';
import '../screens/screens.dart';

class AppRoutes {
  static const String home = '/';
  static const String perfil = '/perfil';
  static const String filaFotos = '/filaFotos';
  static const String columnaFotos = '/columnaFotos';
  static const String iconsDisplay = '/iconsDisplay';
  static const String challenge = '/challenge';
  static const String filasColumnas = '/filasColumnas';
  static const String contadorClics = '/contadorClics';
  static const String perfilInstagram = '/perfilInstagram';
  static const String juego = '/juego';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),
    perfil: (context) => const PerfilPage(),
    filaFotos: (context) => const FilaFotosPage(),
    columnaFotos: (context) => const ColumnaFotosPage(),
    iconsDisplay: (context) => const IconsDisplayPage(),
    challenge: (context) => const ChallengePage(),
    filasColumnas: (context) => const FilasColumnasPage(),
    contadorClics: (context) => const ContadorClics(title: 'Contador/Decrementador de Clics'),
    perfilInstagram: (context) => const PaginaPrincipal(),
    juego: (context) => const JuegoPage(),
  };
}