import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenge Ejercicio 2'),
      ),
      drawer: const AppDrawer(), // Mantiene el Drawer siempre visible
      body: Center(
        child: Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(4, 4), // Sombra hacia la esquina inferior derecha
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Challenge',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontStyle: FontStyle.italic,
                  ), // Estilo del texto adaptado al theme
            ),
          ),
        ),
      ),
    );
  }
}