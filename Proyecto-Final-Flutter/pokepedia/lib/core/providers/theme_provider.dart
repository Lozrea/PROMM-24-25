import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Clase que gestiona el estado del tema visual (modo claro u oscuro) de la aplicación. 
/// Permite cambiar el tema y almacenar la preferencia en `SharedPreferences` para mantenerla entre sesiones.
class ThemeProvider with ChangeNotifier {
  static const sharedPreferencesKey = 'theme_mode';

  // Establecer el modo de tema por defecto como oscuro
  ThemeMode mode = ThemeMode.dark;

  // Getter para saber si el modo actual es oscuro
  bool get isDarkMode {
    return mode == ThemeMode.dark;
  }

  // Cargar el tema desde SharedPreferences
  void loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    var themeMode = prefs.getString(sharedPreferencesKey);

    if (themeMode != null) {
      mode = themeMode == 'light' ? ThemeMode.light : ThemeMode.dark;
    } else {
      mode = ThemeMode.light;
    }

    notifyListeners();
  }

  // Cambiar el modo de tema y guardarlo en SharedPreferences
  void setMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(sharedPreferencesKey, themeMode.name);
    mode = themeMode;
    notifyListeners();
  }

  // Alternar entre modo claro y oscuro
  void toggleMode() {
    if (mode == ThemeMode.light) {
      setMode(ThemeMode.dark);
    } else {
      setMode(ThemeMode.light);
    }
  }
}
