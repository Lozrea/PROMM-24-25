import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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