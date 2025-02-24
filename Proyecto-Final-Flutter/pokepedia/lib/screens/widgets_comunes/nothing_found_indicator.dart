import 'package:flutter/material.dart';

// Clase que muestra un mensaje cuando no se encuentran resultados en la búsqueda
class NothingFoundIndicator extends StatelessWidget {
  const NothingFoundIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: [
            Image.asset(
              "assets/images/confused-pikachu.png",
              width: 200,
            ),
            Text(
              "Ups! Nothing found...",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
