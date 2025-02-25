import 'package:flutter/material.dart';
import 'package:pokepedia/core/utils/extensions/color_extension.dart';

// Clase que define los temas de la app tanto para el tema claro como el oscuro.
// Se establece el color primario, los estilos de texto y los temas para las interfaces de usuario
class PokepediaAppTheme {
  static const primaryColor = Color(0xFFC20032);

  static final materialColor = primaryColor.toMaterialColor();

  static const poppinsTextStyle = TextStyle(fontFamily: 'Poppins');

  static final titleStyle = poppinsTextStyle.copyWith(
    fontWeight: FontWeight.bold
  );

  // Define un estilo de texto para los títulos en negrita
  static const labelStyle = TextStyle(
    color: Colors.black45,
    fontWeight: FontWeight.bold
  );

  // Define los estilos de texto para diferentes elementos de la UI
  static final textTheme = TextTheme(
    headlineLarge: poppinsTextStyle,
    headlineMedium: poppinsTextStyle,
    headlineSmall: poppinsTextStyle,
    titleLarge: titleStyle,
    titleMedium: titleStyle,
    titleSmall: titleStyle,
    labelLarge: labelStyle,
    labelMedium: labelStyle,
    labelSmall: labelStyle
  );

  /// TEMA CLARO
  static final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF)
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.grey.shade100
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: Colors.white70,
      elevation: 3,
      labelStyle: TextStyle(color: Colors.black),
      selectedColor: Colors.black12,
      side: BorderSide(color: Colors.transparent),
      surfaceTintColor: Colors.white,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: const Color.fromARGB(255, 240, 240, 240),
      hintStyle: const TextStyle(
        color: Color.fromARGB(255, 180, 180, 180)
      ),
      prefixIconColor: const Color.fromARGB(255, 100, 100, 100),
    ),
    primaryColor: primaryColor,
    primarySwatch: primaryColor.toMaterialColor(),
    scaffoldBackgroundColor: Colors.white,
    listTileTheme: const ListTileThemeData(
      subtitleTextStyle: TextStyle(color: Colors.black87),
      titleTextStyle: TextStyle(color: Colors.black),
    ),
    textTheme: textTheme
  );


  /// TEMA OSCURO
  static const darkBackgroundColor = Color(0xFF050505);

  // Ajusta el color primario para que sea más oscuro
  static final darkPrimaryColor = HSLColor.fromColor(const Color(0xFFFFFFFF))
    .withLightness(0.5)
    .toColor();

  static final darkTitleStyle = titleStyle.copyWith(
    color: Colors.white
  );

  static final darkLabelStyle = labelStyle.copyWith(
    color: Colors.white54
  );

  static final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: darkPrimaryColor,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: HSLColor.fromColor(darkBackgroundColor).withLightness(0.1).toColor(),
      modalBarrierColor: HSLColor.fromColor(darkBackgroundColor).withAlpha(0.75).toColor()
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    chipTheme: const ChipThemeData(
      backgroundColor: Colors.white10,
      labelStyle: TextStyle(color: Colors.white),
      selectedColor: Colors.white24,
      side: BorderSide(color: Colors.transparent),
      surfaceTintColor: Colors.black87,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(16.0),
      ),
      filled: true,
      fillColor: const Color.fromARGB(255, 25, 25, 25),
      prefixIconColor: const Color.fromARGB(255, 100, 100, 100),
      hintStyle: const TextStyle(
        color: Color.fromARGB(255, 75, 75, 75)
      ),
    ),
    listTileTheme: const ListTileThemeData(
      titleTextStyle: TextStyle(color: Colors.white),
      subtitleTextStyle: TextStyle(color: Colors.white70),
    ),
    primaryColor: darkPrimaryColor.toMaterialColor(),
    scaffoldBackgroundColor: darkBackgroundColor,
    textTheme: TextTheme(
      headlineLarge: poppinsTextStyle,
      headlineMedium: poppinsTextStyle,
      headlineSmall: poppinsTextStyle,
      labelLarge: darkLabelStyle,
      labelMedium: darkLabelStyle,
      labelSmall: darkLabelStyle,
      titleLarge: darkTitleStyle,
      titleMedium: darkTitleStyle,
      titleSmall: darkTitleStyle,
    ),
  );
}