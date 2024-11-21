import 'package:flutter/material.dart';
 // Header del perfil
import 'perfil_header.dart';
// Botones de acción
import 'perfil_acciones.dart';
// Historias destacadas
import 'perfil_historias.dart';
// Iconos entre las historias destacadas y el grid de fotos
import 'perfil_iconos.dart';
// Cuadrícula de imágenes
import 'perfil_grid.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          PerfilHeader(), // Encabezado con la imagen, estados, bio
          SizedBox(height: 20),
          PerfilActions(), // Botón editar perfil
          SizedBox(height: 20),
          PerfilHistorias(), // Historias destacadas
          SizedBox(height: 20),
          PerfilIconos(), // Mostramos los iconos de cuadrícula y etiquetado
          SizedBox(height: 10),
          Divider(thickness: 1),
          PerfilGrid(), // Galería de imágenes (Grid)
        ],
      ),
    );
  }
}