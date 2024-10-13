// cards.dart
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:juego_pares/config/theme/app_theme.dart';
import 'package:juego_pares/shared/floatingcoutner.dart';

class FlipCardGame extends StatefulWidget {
  final int numOfPairs;
  final Function(int) onGameComplete;
  final GlobalKey<FloatingTimerState> timerKey; // Cambiamos FloatingTimer a su GlobalKey

  const FlipCardGame({
    super.key,
    required this.numOfPairs,
    required this.onGameComplete,
    required this.timerKey, // Recibimos la clave aquí
  });

  @override
  FlipCardGameState createState() => FlipCardGameState();
}

class FlipCardGameState extends State<FlipCardGame> {
  List<FlipCardController> cardControllers = [];
  List<Color> cardColors = [];
  List<bool> flippedCards = [];
  int firstCardIndex = -1;
  int secondCardIndex = -1;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _generateCards();
  }

  // Generar colores y mezclar cartas
  void _generateCards() {
    List<Color> colors = [];
    for (int i = 0; i < widget.numOfPairs; i++) {
      colors.add(colorList[i % colorList.length]); // Añadir color dos veces (para el par)
      colors.add(colorList[i % colorList.length]);
    }
    colors.shuffle(); // Mezclar los colores

    cardColors = colors;
    flippedCards = List<bool>.filled(widget.numOfPairs * 2, false);
    cardControllers = List.generate(widget.numOfPairs * 2, (index) => FlipCardController());
  }

  // Manejar el tap en una carta
  void _onCardTap(int index) {
    if (flippedCards[index]) return; // Si ya está volteada, no hacer nada

    setState(() {
      if (firstCardIndex == -1) {
        firstCardIndex = index;
        cardControllers[index].flipcard(); // Voltear la primera carta
      } else if (secondCardIndex == -1) {
        secondCardIndex = index;
        cardControllers[index].flipcard(); // Voltear la segunda carta

        if (cardColors[firstCardIndex] == cardColors[secondCardIndex]) {
          // Si hay un par
          flippedCards[firstCardIndex] = true;
          flippedCards[secondCardIndex] = true;
          score++; // Incrementar puntaje

          // Verifica si se han encontrado todos los pares
          if (score == widget.numOfPairs) {
            widget.timerKey.currentState?.stopTimer(); 
          }


          firstCardIndex = -1;
          secondCardIndex = -1;
        } else {
          // Si no es un par, volver a voltear después de 1 segundo
          Future.delayed(const Duration(seconds: 1), () {
            cardControllers[firstCardIndex].flipcard();
            cardControllers[secondCardIndex].flipcard();
            firstCardIndex = -1;
            secondCardIndex = -1;
            setState(() {});
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Dos columnas para tener cuatro cartas
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: widget.numOfPairs * 2,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _onCardTap(index),
                child: FlipCard(
                  controller: cardControllers[index], // Usamos el controlador aquí
                  rotateSide: RotateSide.bottom,
                  axis: FlipAxis.horizontal,
                  frontWidget: _buildFrontCard(),
                  backWidget: _buildBackCard(cardColors[index]),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Puntaje: $score',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }

  // Parte frontal de la carta (negra)
  Widget _buildFrontCard() {
    return Container(
      height: 20,
      width: 14,
      color: Colors.black,
    );
  }

  // Parte trasera de la carta (color)
  Widget _buildBackCard(Color color) {
    return Container(
      height: 20,
      width: 14,
      color: color,
    );
  }
}
