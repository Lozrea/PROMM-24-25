import 'package:flutter/material.dart';

var images = [
    'assets/images_instagram/vias.jpg',
    'assets/images_instagram/sky.jpg',
    'assets/images_instagram/galaxy.jpg',
    'assets/images_instagram/mountains.jpg',
    'assets/images_instagram/pelicans.jpg',
    'assets/images_instagram/fishing.jpg',
    'assets/images_instagram/wood_hpuse.jpg',
    'assets/images_instagram/skyline.jpg',
    'assets/images_instagram/walking.jpg',
  ];

class PerfilGrid extends StatelessWidget {
  const PerfilGrid({super.key});  

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
        itemCount: images.length, // Mostramos tantas imágenes como en la lista
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey.shade300,
            child: Image.asset(
              images[index], // Asignamos la imagen correspondiente a cada casilla
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}