import 'package:flutter/material.dart';
import 'package:pokepedia/core/providers/theme_provider.dart';
import 'package:provider/provider.dart';

// Widget para alternar el tema entre claro y oscuro
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      color: const Color.fromARGB(255, 10, 10, 10),
      key: const Key('TOGGLE_THEME'),
      icon: Icon(
        themeProvider.mode == ThemeMode.dark
          ? Icons.light_mode
          : Icons.dark_mode,
      ),
      onPressed: () {
        themeProvider.toggleMode(); // Alterna el modo de tema
      },
    );
  }
}
