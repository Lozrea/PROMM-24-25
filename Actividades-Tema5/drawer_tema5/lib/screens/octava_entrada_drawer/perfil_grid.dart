import 'package:flutter/material.dart';

class PerfilGrid extends StatelessWidget {
  const PerfilGrid({super.key});

  // Lista estática de URLs de imágenes distintas (de la página web Lorem Picsum)
  final List<String> imageUrls = const [
    'https://picsum.photos/id/204/5000/3333.jpg',
    'https://picsum.photos/id/38/1280/960.jpg',
    'https://picsum.photos/id/120/4928/3264.jpg',
    'https://picsum.photos/id/29/4000/2670.jpg',
    'https://picsum.photos/id/244/4288/2848.jpg',
    'https://picsum.photos/id/27/3264/1836.jpg',
    'https://picsum.photos/id/76/4912/3264.jpg',
    'https://picsum.photos/id/203/4032/3024.jpg',
    'https://picsum.photos/id/22/4434/3729',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 1,
        ),
        itemCount: imageUrls.length, // Mostramos tantas imágenes como en la lista
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey.shade300,
            child: Image.network(
              imageUrls[index], // Asignamos la imagen correspondiente a cada casilla
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}