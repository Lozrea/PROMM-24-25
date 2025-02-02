import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class FilaFotosPage extends StatelessWidget {
  const FilaFotosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fotos en Fila'), backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
      drawer: const AppDrawer(), // Mantiene el Drawer siempre visible
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://picsum.photos/250?image=9', width: 100),
            const SizedBox(width: 10,),
            Image.network('https://picsum.photos/id/237/200/200', width: 100),
            const SizedBox(width: 10),
            Image.network('https://picsum.photos/seed/picsum/200/200', width: 100),
          ],
        ),
      ),
    );
  }
}