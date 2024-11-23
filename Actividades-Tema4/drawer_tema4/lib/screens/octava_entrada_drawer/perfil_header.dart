import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerfilHeader extends StatelessWidget {
  const PerfilHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen de perfil
          const CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(
              'https://picsum.photos/id/177/2515/1830.jpg', // Imagen perfil (avatar)
            ),
          ),
          const SizedBox(width: 20),
          // Información de perfil: estados y biografía
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Estados: Publicaciones, seguidores y seguidos
                    _buildStatColumn('1.026', 'Publicaciones'),
                    _buildStatColumn('859', 'Seguidores'),
                    _buildStatColumn('211', 'Seguidos'),
                  ],
                ),
                const SizedBox(height: 10),
                // Nombre de usuario y bio
                Text(
                  'John Doe',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Nunca sabes lo que te depara el futuro.',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'faqsandroid.com/',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget para las columnas de Publicaciones, Seguidores y Seguidos
  Widget _buildStatColumn(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: GoogleFonts.roboto(fontSize: 14),
        ),
      ],
    );
  }
}