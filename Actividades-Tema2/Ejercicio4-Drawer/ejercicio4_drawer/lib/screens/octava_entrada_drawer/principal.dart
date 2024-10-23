import 'package:flutter/material.dart';
// Importamos la pantalla de perfil
import 'perfil_screen.dart';
// Importamos la barra de navegación inferior
import 'barra_navegacion_inf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil Instagram. Ejercicio 4',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PaginaPrincipal(), // Cargamos la pantalla principal
    );
  }
}

class PaginaPrincipal extends StatelessWidget {
  const PaginaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> entradas = [
      Container(
        padding: const EdgeInsets.all(16.0),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Alineamos el texto y la flecha
          children: [
            Row(
              children: [
                Text(
                  'johnnyd',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 5), // Añadimos espacio entre el texto y el icono de la flechita hacia abajo
                Icon(
                  Icons.arrow_drop_down, // Flechita hacia abajo
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      ),
      // Aquí cargamos la pantalla de perfil
      const PerfilScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Principal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu), // Icono de menú hamburguesa
            onPressed: () {
              // No hace falta que tenga funcionalidad
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: entradas.length,
        itemBuilder: (context, index) {
          return entradas[index];
        },
      ),
      bottomNavigationBar: const BarraNavegacionInferior(), // Añadimos la barra de navegación inferior
    );
  }
}