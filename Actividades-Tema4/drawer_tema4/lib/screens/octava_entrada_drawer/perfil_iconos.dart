import 'package:flutter/material.dart';

class PerfilIconos extends StatelessWidget {
  const PerfilIconos({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0), // Alineación central
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.grid_on, size: 28), // Icono de cuadrícula
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_outline, size: 28), // Icono de perfil
          ),
        ],
      ),
    );
  }
}