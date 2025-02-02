// main.dart
import 'package:drawer_tema5/routes/routes.dart';
import 'package:drawer_tema5/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drawer Navigation App',
      theme: AppTheme.lightTheme, // Tema claro
      darkTheme: AppTheme.darkTheme, // Tema oscuro opcional
      themeMode: ThemeMode.system, // Cambia según las preferencias del sistema
      initialRoute: AppRoutes.home, // Usamos la constante definida en routes.dart
      routes: AppRoutes.routes, // Mapa de rutas definido en routes.dart
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drawer Navigation App")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/id/53/300/200'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                'Menú de Navegación',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            _drawerItem(context, Icons.person, 'Perfil', '/perfil'),
            _drawerItem(context, Icons.photo, 'Fotos en Fila', '/filaFotos'),
            _drawerItem(context, Icons.photo_album, 'Fotos en Columna', '/columnaFotos'),
            _drawerItem(context, Icons.star, 'Mostrar Iconos', '/iconsDisplay'),
            _drawerItem(context, Icons.extension, 'Challenge', '/challenge'),
            _drawerItem(context, Icons.grid_view, 'Filas y Columnas anidadas', '/filasColumnas'),
            _drawerItem(context, Icons.add, 'Contador y decrementador de clics', '/contadorClics'),
            _drawerItem(context, Icons.camera_alt, 'Perfil Instagram', '/perfilInstagram'),
            _drawerItem(context, Icons.gamepad, 'Captura al alien', '/juego'),
            _drawerItem(context, Icons.assignment, 'Formulario', '/formulario'), // Entrada para el formulario
            _drawerItem(context, Icons.question_mark, 'Formulario Juego Adivinanza', '/formulario_juego'), // Entrada para el formulario para jugar a adivinar un número aleatorio
          ],
        ),
      ),
      body: Center(
        child: Text(
          "Bienvenido a la Aplicación Drawer",
          style: GoogleFonts.lobster(fontSize: 28, color: Colors.deepPurple),
        ),
      ),
    );
  }

  Widget _drawerItem(BuildContext context, IconData icon, String title, String routeName) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}