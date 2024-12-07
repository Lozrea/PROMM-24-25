// lib/screens/guess_number_page.dart
import 'package:flutter/material.dart';
import 'dart:math';

class GuessNumberPage extends StatefulWidget {
  const GuessNumberPage({super.key});

  @override
  State<GuessNumberPage> createState() => _GuessNumberPageState();
}

class _GuessNumberPageState extends State<GuessNumberPage> {
  final TextEditingController _numberController = TextEditingController();
  late int _secretNumber;
  String _message = '';
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();
    _generateSecretNumber();
  }

  // Genera un número aleatorio entre 1 y 100
  void _generateSecretNumber() {
    _secretNumber = Random().nextInt(100) + 1; // Número entre 1 y 100
    _message = 'Adivina el número secreto (entre 1 y 100).';
    _isSuccess = false;
  }

  void _checkNumber() {
    if (_numberController.text.isEmpty) {
      _showSnackBar('Por favor, introduce un número.');
      return;
    }

    final int? guessedNumber = int.tryParse(_numberController.text);
    if (guessedNumber == null || guessedNumber < 1 || guessedNumber > 100) {
      _showSnackBar('Introduce un número válido entre 1 y 100.');
      return;
    }

    setState(() {
      if (guessedNumber == _secretNumber) {
        _isSuccess = true;
        _message = '¡Correcto! El número secreto era $_secretNumber.';
      } else if (guessedNumber < _secretNumber) {
        _message = 'El número es mayor que $guessedNumber. Intenta de nuevo.';
      } else {
        _message = 'El número es menor que $guessedNumber. Intenta de nuevo.';
      }
    });

    _numberController.clear();
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adivina el Número'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Campo de entrada para el número
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Introduce un número',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            /* // Botón para verificar el número
            ElevatedButton(
              onPressed: _checkNumber,
              child: const Text('Comprobar'),
            ), */

            // Botón para reiniciar el juego si se ha acertado
            if (_isSuccess)
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _generateSecretNumber();
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Jugar de nuevo'),
              ),
          ],
        ),
      ),
      // Botón flotante para verificar el número
      floatingActionButton: FloatingActionButton(
        onPressed: _checkNumber,
        child: const Icon(Icons.check),
      ),
    );
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }
}