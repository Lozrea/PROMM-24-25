// Ruta: lib/routes/routes.dart
import 'package:drawer_tema5/main.dart';
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
  static const String formulario = '/formulario'; // Nueva ruta para el formulario
  static const String formularioJuego = '/formulario_juego'; // Nueva ruta para el formulario para jugar a adivinar un número aleatorio

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
    formulario: (context) => const FormularioPage(), // Ruta para el formulario
    formularioJuego: (context) => const GuessNumberPage(), // Ruta para el formulario adivinar un número aleatorio
  };
}