import 'package:flutter/material.dart';
import 'package:pokepedia/database/proveedor_db.dart';


void main() async {
  // Inicialización necesaria al hacer el main() async
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializando la base de datos
  await ProveedorDB.db.initDB();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inconsolata'),
      title: 'Pokedex App',
      initialRoute: '/',
      routes: const {
        // Aquí irán las rutas de las pantallas una vez estén terminadas 
        //'/pruebaAPI': (context) => const ...,
        // '/': (context) => const ...,
        // '/pokepedia': (context) => const ...,
        // SI DA TIEMPO HACER '/galeria': (context) => const ...,
        // '/favoritos': (context) => const ...
      },
    );
  }
}
