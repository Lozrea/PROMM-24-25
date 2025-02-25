import 'package:flutter/material.dart';
import 'package:pokepedia/core/providers/theme_provider.dart';
import 'package:provider/provider.dart';

// Extensión sobre la clase `Color` para convertir colores y obtener variantes
extension ColorExtension on Color {
  // Convierte un color a un `MaterialColor` con sus diferentes tonos
  MaterialColor toMaterialColor() {
    // Convertimos los valores de r, g, b a enteros en el rango de 0 a 255
    final int red = (r * 255).toInt();
    final int green = (g * 255).toInt();
    final int blue = (b * 255).toInt();

    // Calcular el valor de color en 32 bits utilizando .r, .g, .b, .a
    final int alpha = (a * 255).toInt(); // Convertir de double a int
    final int value = (alpha << 24) | (red << 16) | (green << 8) | blue; // Combinar los componentes ARGB en un valor entero


    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(value, shades);
  }

  // Obtiene una variante más oscura del color
  Color get darkVariant {
    return HSLColor.fromColor(this).withLightness(0.4).toColor();
  }

  // Obtiene una variante más clara del color
  Color get lightVariant {
    return HSLColor.fromColor(this).withLightness(0.8).toColor();
  }

  // Obtiene el color adecuado según el modo de tema (oscuro o claro)
  Color getColorByThemeMode(BuildContext context) {
    final ThemeMode themeMode = Provider.of<ThemeProvider>(context).mode;

    return switch(themeMode) {
      ThemeMode.dark => darkVariant,
      ThemeMode.light => lightVariant,
      _ => lightVariant
    };
  }
}