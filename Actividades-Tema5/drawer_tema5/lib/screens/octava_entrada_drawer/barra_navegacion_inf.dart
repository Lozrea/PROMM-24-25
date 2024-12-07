import 'package:flutter/material.dart';

class BarraNavegacionInferior extends StatelessWidget {
  const BarraNavegacionInferior({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Mantiene todos los iconos visibles
      currentIndex: 0, // Por defecto seleccionamos el primer icono
      onTap: (index) {
        // No es necesario añadir funcionalidad por ahora
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined), // Icono de home
          label: '', // Sin etiqueta
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search), // Icono de búsqueda
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined), // Icono de añadir
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border), // Icono de favoritos
          label: '',
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 15, // Tamaño del avatar
            backgroundImage: NetworkImage(
              'https://picsum.photos/id/177/2515/1830.jpg', // Imagen del perfil
            ),
          ),
          label: '', // Sin etiqueta
        ),
      ],
    );
  }
}