import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/perfil.dart';
import 'screens/fila_fotos.dart';
import 'screens/columna_fotos.dart';
import 'screens/icons_display.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawer Navigation App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drawer Navigation App"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
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
            ListTile(
              leading: const Icon(Icons.person, color: Colors.deepPurple),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PerfilPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo, color: Colors.deepPurple),
              title: const Text('Fotos en Fila'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FilaFotosPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_album, color: Colors.deepPurple),
              title: const Text('Fotos en Columna'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  const ColumnaFotosPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.deepPurple),
              title: const Text('Mostrar Iconos'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  const IconsDisplayPage()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenido a la Aplicación",
              style: GoogleFonts.lobster(fontSize: 28, color: Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}