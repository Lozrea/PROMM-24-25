import 'package:flutter/material.dart';

class IconsDisplayPage extends StatelessWidget {
  const IconsDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mostrar Iconos'), backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
      body: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.home, size: 40, color: Colors.deepPurple),
            Icon(Icons.star, size: 40, color: Colors.amber),
            Icon(Icons.favorite, size: 40, color: Colors.red),
            Icon(Icons.settings, size: 40, color: Colors.blue),
            Icon(Icons.person, size: 40, color: Colors.green),
          ],
        ),
      ),
    );
  }
}