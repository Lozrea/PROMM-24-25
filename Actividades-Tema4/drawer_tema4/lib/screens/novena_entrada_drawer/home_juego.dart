import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

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
  }

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  // Usamos un callback para que el diálogo se muestre después de la construcción inicial
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showInstructions();
  });
}

  // Diálogo de instrucciones al iniciar el juego
  void showInstructions() {
    showDialog(
      context: context,
      barrierDismissible: false, // Evita que el usuario cierre el diálogo al tocar fuera de él
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Instrucciones'),
          content: const Text(
            '¡Captura al alien antes de que desaparezca!\n\n'
            '- Cada alien capturado suma 1 punto.\n'
            '- Si un alien desaparece sin capturarlo, pierdes 2 puntos.\n\n'
            '¿Estás listo para el desafío?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                startGame(); // Inicia el juego
              },
              child: const Text(
                'Empezar',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                Navigator.of(context).pop(); // Regresa a la pantalla anterior
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void startGame() {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        posX = Random().nextDouble() * (MediaQuery.of(context).size.width - 50);
        posY = Random().nextDouble() * (MediaQuery.of(context).size.height - 150);
        opacityLevel = 1.0; // Restablecemos la opacidad para hacer visible la imagen
      });

      // Si no capturan al alien en el tiempo dado, mostramos un mensaje
      Future.delayed(const Duration(seconds: 1), () {
        if (!mounted) return; // Verificamos si el widget sigue montado
        if (opacityLevel == 1.0) {
          setState(() {
            score -= 2;
            opacityLevel = 0.0; // Hacemos desaparecer la imagen
          });

          // Mostramos el mensaje de fallo
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('¡Fallaste! No lograste atrapar al alien.', textAlign: TextAlign.center),
              backgroundColor: Colors.redAccent,
              duration: Duration(seconds: 1),
            ),
          );
        }
      });
    });
  }

  void onImageTapped() {
    setState(() {
      score += 1;
      opacityLevel = 0.0; // Reducimos la opacidad para hacer desaparecer la imagen al tocarla
    });

    // Logra capturar al alien, mostramos el mensaje de acierto
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('¡Bien hecho! Capturaste al alien.', textAlign: TextAlign.center),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Captura al alien'),
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