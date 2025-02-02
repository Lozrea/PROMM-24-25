import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class ColumnaFotosPage extends StatelessWidget {
  const ColumnaFotosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fotos en Columna'), backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
      drawer: const AppDrawer(), // Mantiene el Drawer siempre visible
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://picsum.photos/100/100?grayscale', width: 100),
            const SizedBox(height: 10),
            Image.network('https://picsum.photos/id/10/200/200', width: 100),
            const SizedBox(height: 10),
            Image.network('https://picsum.photos/id/40/200/200', width: 100),
          ],
        ),
      ),
    );
  }
}