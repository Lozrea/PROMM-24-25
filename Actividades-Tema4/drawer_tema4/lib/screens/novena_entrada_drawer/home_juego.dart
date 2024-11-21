import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class JuegoPage extends StatefulWidget {
  const JuegoPage({super.key});

  @override
  JuegoPageState createState() => JuegoPageState(); 
}

class JuegoPageState extends State<JuegoPage> {
  int score = 0;
  double posX = 0.0;
  double posY = 0.0;
  double opacityLevel = 1.0; // Usamos esta variable para hacer fade in/out a la imagen
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startGame() {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        posX = Random().nextDouble() * (MediaQuery.of(context).size.width - 50);
        posY = Random().nextDouble() * (MediaQuery.of(context).size.height - 150);
        opacityLevel = 1.0; // Restablecemos la opacidad para hacer visible la imagen
      });

      Future.delayed(const Duration(seconds: 1), () {
        if (opacityLevel == 1.0) {
          setState(() {
            score -= 2;
            opacityLevel = 0.0; // Hacemos desaparecer la imagen
          });
        }
      });
    });
  }

  void onImageTapped() {
    setState(() {
      score += 1;
      opacityLevel = 0.0; // Reducimos la opacidad para hacer desaparecer la imagen al tocarla
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Captura al alien'),
        backgroundColor: Colors.blueGrey.shade900,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Fondo de color sólido con círculos/burbujas decorativas
          Container(
            color: Colors.deepPurple.shade800,
            child: Stack(
              children: [
                Positioned(
                  top: 100,
                  left: 30,
                  child: CircleAvatar( // Burbuja 1
                    radius: 60,
                    backgroundColor: Colors.purple.shade700.withOpacity(0.3),
                  ),
                ),
                Positioned(
                  top: 250,
                  right: 50,
                  child: CircleAvatar( // Burbuja 2
                    radius: 90,
                    backgroundColor: Colors.blue.shade800.withOpacity(0.2),
                  ),
                ),
                Positioned(
                  bottom: 150,
                  left: 80,
                  child: CircleAvatar( // Burbuja 3
                    radius: 70,
                    backgroundColor: Colors.pinkAccent.shade400.withOpacity(0.3),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  right: 20,
                  child: CircleAvatar( // Burbuja 4
                    radius: 40,
                    backgroundColor: Colors.tealAccent.shade700.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'Puntuación: $score',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            left: posX,
            top: posY,
            child: GestureDetector(
              onTap: onImageTapped,
              child: AnimatedOpacity(
                opacity: opacityLevel, // Usamos la opacidad para el fade in y fade out
                duration: const Duration(seconds: 1), // Duración de la animación de transparencia
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 500),
                  scale: opacityLevel == 1.0 ? 1.2 : 0,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Hace que el contenedor que contiene la imagen sea redondo
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5), // Sombra del contenedor (para hacer que no parezca plano)
                          blurRadius: 8,
                          offset: const Offset(4, 4),
                        ),
                      ],
                      image: const DecorationImage(
                        image: AssetImage('assets/alien.png'), // Ruta de la imagen del alien
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}