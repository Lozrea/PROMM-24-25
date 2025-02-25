import 'package:flutter/material.dart';

// Widget que se usa para mostrar el título de una sección
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width, // Toma el ancho total de la pantalla
      child: Padding(
        padding: const EdgeInsets.all(16), // Aplica un padding alrededor del texto
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith( // Personaliza el estilo de texto
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700
          )
        ),
      ),
    );
  }
}