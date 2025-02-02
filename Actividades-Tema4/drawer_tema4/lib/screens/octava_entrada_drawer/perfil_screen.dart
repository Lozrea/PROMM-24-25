import 'package:flutter/material.dart';
// Importamos las secciones del perfil
import 'perfil_header.dart';
import 'perfil_acciones.dart';
import 'perfil_historias.dart';
import 'perfil_grid.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2, // Número de pestañas
      child: SingleChildScrollView(
        child: Column(
          children: [
            PerfilHeader(), // Encabezado con la imagen, estados, bio
            SizedBox(height: 20),
            PerfilActions(), // Botón editar perfil (no tiene funcionalidad)
            SizedBox(height: 20),
            PerfilHistorias(), // Historias destacadas
            SizedBox(height: 20),
            Divider(thickness: 1),
            // TabBar para las pestañas
            TabBar(
              labelColor: Colors.black, // Color del texto activo
              unselectedLabelColor: Colors.grey, // Color del texto inactivo
              indicatorColor: Colors.black, // Indicador de la pestaña activa
              tabs: [
                Tab(icon: Icon(Icons.grid_on)), // Pestaña de cuadrícula
                Tab(icon: Icon(Icons.person_outline)), // Pestaña de etiquetado
              ],
            ),
            // TabBarView para mostrar el contenido de las pestañas
            SizedBox(
              height: 400, // Altura de las pestañas
              child: TabBarView(
                children: [
                  PerfilGrid(), // Contenido de la primera pestaña (Galería)
                  Center( // Contenido de la segunda pestaña (Etiquetado)
                    child: Text(
                      'No tienes fotos etiquetadas.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}