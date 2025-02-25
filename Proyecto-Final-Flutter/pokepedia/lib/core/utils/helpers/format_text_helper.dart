import 'package:intl/intl.dart';

// Clase que contiene métodos estáticos para formatear texto relacionado con Pokemons
class FormatTextHelper {
  // Formatea el texto descriptivo de un Pokémon
  static String formatFlavorText(Map<String, dynamic> data, {
    String collection = 'flavor_texts',
    String key = 'flavor_text'
  }) {
    final flavorTexts = data[collection] != null
      ? (data[collection] as List)
      : null;

    if (flavorTexts != null && flavorTexts.isNotEmpty) {
      return flavorTexts[0][key].replaceAll('\n', ' '); // Reemplaza saltos de línea por espacios
    }

    return '';
  }
  
  // Formatea un nombre, asegurándose de que empiece con mayúscula
  static String formatName(String name) {
    return toBeginningOfSentenceCase(name.replaceAll('-', ' '));
  }
}