import 'package:flutter/material.dart';
import 'package:juego_pares/shared/cards.dart';
import 'package:juego_pares/shared/floatingcoutner.dart';
import 'package:juego_pares/presentation/providers/score_manager.dart'; 

class EasyScreen extends StatefulWidget {
  static const String name = 'easy';

  const EasyScreen({super.key});

  @override
  State<EasyScreen> createState() => _EasyScreenState();
}

class _EasyScreenState extends State<EasyScreen> {
  late FlipCardGame flipCardGame;
  int finalTime = 0;
  int highScore = 0;

  final GlobalKey<FloatingTimerState> _timerKey = GlobalKey<FloatingTimerState>();

  @override
  void initState() {
    super.initState();
    flipCardGame = FlipCardGame(
      numOfPairs: 4,
      onGameComplete: _onGameComplete,
      timerKey: _timerKey,
    );
    _loadHighScore(); // Cargar la puntuación más alta
  }

  // Cargar la puntuación más alta del nivel fácil
  Future<void> _loadHighScore() async {
    int score = await ScoreManager.getHighScore('easy');
    setState(() {
      highScore = score;
    });
  }

  // Esta función se llamará cuando el juego termine
  void _onGameComplete(int time) {
    setState(() {
      finalTime = time; // Guardamos el tiempo final que se pasa desde FloatingTimer
    });

    // Comparar el tiempo actual con la puntuación más alta y guardarla si es menor
    if (finalTime < highScore || highScore == 0) {
      ScoreManager.saveHighScore('easy', finalTime);
      setState(() {
        highScore = finalTime;
      });
    }

    // Mostrar diálogo con la puntuación final
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Juego Terminado'),
          content: Text('¡Encontraste todos los pares en $finalTime segundos!\nPuntuación más alta: $highScore segundos'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modo Fácil'),
      ),
      body: Stack(
        children: [
          flipCardGame,
          FloatingTimer(
            key: _timerKey,
            onTimerStop: _onGameComplete, // Pasar la función al temporizador
          ),
        ],
      ),
      // Mostrar la puntuación más alta en la pantalla
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Puntuación más alta: $highScore segundos',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
