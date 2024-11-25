import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerfilActions extends StatelessWidget {
  const PerfilActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Ajustamos el padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton('Editar perfil', context),
        ],
      ),
    );
  }

  // Botón de acción personalizado
  Widget _buildActionButton(String label, BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          // Mostrar un mensaje al presionar el botón
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No hemos podido acceder')),
          );
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: GoogleFonts.roboto(fontSize: 14),
        ),
      ),
    );
  }
}
