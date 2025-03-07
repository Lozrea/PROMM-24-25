import 'package:flutter/material.dart';

// Clase que muestra un mensaje de error cuando ocurre un problema
class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: [
            Image.asset(
              "assets/images/scared-psyduck.png",
              width: 200,
            ),
            Text(
              "Ups, something went wrong...",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "Try again latter",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
