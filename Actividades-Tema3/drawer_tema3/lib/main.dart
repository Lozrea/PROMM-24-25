// main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/screens.dart';

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
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/perfil': (context) => const PerfilPage(),
        '/filaFotos': (context) => const FilaFotosPage(),
        '/columnaFotos': (context) => const ColumnaFotosPage(),
        '/iconsDisplay': (context) => const IconsDisplayPage(),
        '/challenge': (context) => const ChallengePage(),
        '/filasColumnas': (context) => const FilasColumnasPage(),
        '/contadorClics': (context) => const ContadorClics(title: 'Contador/Decrementador de Clics'),
        '/perfilInstagram': (context) => const PaginaPrincipal(),
        '/juego': (context) => const JuegoPage(), // Nueva ruta para el juego
      },
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
            _drawerItem(context, Icons.gamepad, 'Captura al alien', '/juego'), // Nueva entrada para el juego
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