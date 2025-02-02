import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class FilasColumnasPage extends StatelessWidget {
  const FilasColumnasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo de Filas y Columnas Anidadas'),
      ),
      drawer: const AppDrawer(), // Mantiene el Drawer siempre visible
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Primera fila: Una imagen centrada
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconWithLabel(
                  iconData: Icons.phone_in_talk,
                  label: 'Llamar por teléfono',
                ),
              ],
            ),
            SizedBox(height: 20), // Espacio entre filas

            // Segunda fila: Dos imágenes centradas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconWithLabel(
                  iconData: Icons.phone_forwarded,
                  label: 'Reenviar llamada',
                ),
                SizedBox(width: 20), // Espacio entre las imágenes
                IconWithLabel(
                  iconData: Icons.phone_callback,
                  label: 'Devolver llamada',
                ),
              ],
            ),
            SizedBox(height: 20),

            // Tercera fila: Tres imágenes centradas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconWithLabel(
                  iconData: Icons.phone_android,
                  label: 'Teléfono móvil',
                ),
                SizedBox(width: 20), // Espacio entre las imágenes
                IconWithLabel(
                  iconData: Icons.phone_locked,
                  label: 'Teléfono bloqueado',
                ),
                SizedBox(width: 20),
                IconWithLabel(
                  iconData: Icons.phone_paused,
                  label: 'Llamada en espera',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget personalizado para mostrar ícono con etiqueta
class IconWithLabel extends StatelessWidget {
  final IconData iconData;
  final String label;

  const IconWithLabel({
    super.key,
    required this.iconData,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(iconData, size: 60, color: Theme.of(context).primaryColor), // Uso del theme
        const SizedBox(height: 5),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge, // Uso del theme
        ),
      ],
    );
  }
}