import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerfilHistorias extends StatelessWidget {
  const PerfilHistorias({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de textos para cada historia destacada
    final List<String> textosDestacados = [
      'Nuevo',
      'Conciertos',
      'Amigos',
      'Mascotas',
    ];

    // Imágenes para las historias destacadas (excepto el primer círculo)
    final List<String> imagenesDestacadas = [
      'https://picsum.photos/id/117/1544/1024.jpg',
      'https://picsum.photos/id/1011/200/200',
      'https://picsum.photos/id/659/2731/1536.jpg',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(4, (index) {
          // Si el índice es 0, mostramos el icono "+", de lo contrario una imagen
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (index == 0) {
                    // Mostrar mensaje de snack bar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Añadiendo historia...'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade300,
                  child: index == 0
                      ? const Icon(Icons.add, color: Colors.black)
                      : ClipOval(
                          child: Image.network(
                            imagenesDestacadas[index - 1], // Asignamos la imagen
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                textosDestacados[index], // Asignamos el texto respectivo
                style: GoogleFonts.roboto(fontSize: 12),
              ),
            ],
          );
        }),
      ),
    );
  }
}