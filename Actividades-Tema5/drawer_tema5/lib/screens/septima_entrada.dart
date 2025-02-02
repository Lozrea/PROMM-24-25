import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class ContadorClics extends StatefulWidget {
  const ContadorClics({super.key, required this.title});

  final String title;

  @override
  State<ContadorClics> createState() => _ContadorClicsState();
}

class _ContadorClicsState extends State<ContadorClics> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const AppDrawer(), // Mantiene el Drawer siempre visible
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Has pulsado el botón Incrementar este número de veces:', 
            style: Theme.of(context).textTheme.bodyLarge, // Uso del theme
            ),
            
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium, // Uso del theme
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: const Text('Incrementar'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _decrementCounter,
                  child: const Text('Decrementar'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetCounter,
                  child: const Text('Poner a cero'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}