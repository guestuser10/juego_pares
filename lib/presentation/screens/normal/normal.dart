import 'package:flutter/material.dart';
import 'package:juego_pares/shared/cards.dart';
import 'package:juego_pares/shared/floatingcoutner.dart';
import 'package:juego_pares/presentation/providers/score_manager.dart'; 

class NormalScreen extends StatefulWidget {
  static const String name = 'normal';

  const NormalScreen({super.key});

  @override
  State<NormalScreen> createState() => _NormalScreenState();
}

class _NormalScreenState extends State<NormalScreen> {
  late FlipCardGame flipCardGame;
  int finalTime = 0;
  int highScore = 0;

  final GlobalKey<FloatingTimerState> _timerKey = GlobalKey<FloatingTimerState>();

  @override
  void initState() {
    super.initState();
    flipCardGame = FlipCardGame(
      numOfPairs: 5,
      onGameComplete: _onGameComplete,
      timerKey: _timerKey,
    );
    _loadHighScore(); // Cargar la puntuación más alta
  }

  // Cargar la puntuación más alta del nivel normal
  Future<void> _loadHighScore() async {
    int score = await ScoreManager.getHighScore('normal');
    setState(() {
      highScore = score;
    });
  }

  // Esta función se llama cuando el juego termina y recibe el tiempo desde el cronómetro
  void _onGameComplete(int time) {
    setState(() {
      finalTime = time; // Guardamos el tiempo final correctamente
    });

    // Comparar el tiempo actual con la puntuación más alta y guardarla si es menor
    if (finalTime < highScore || highScore == 0) {
      ScoreManager.saveHighScore('normal', finalTime);
      setState(() {
        highScore = finalTime;
      });
    }

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
        title: const Text('Modo normal'),
      ),
      body: Stack(
        children: [
          flipCardGame,
          FloatingTimer(
            key: _timerKey,
            onTimerStop: _onGameComplete, // Pasamos el tiempo a onGameComplete cuando se detiene
          ),
        ],
      ),
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
