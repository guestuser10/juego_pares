// floatingcounter.dart
import 'dart:async'; 
import 'package:flutter/material.dart';

class FloatingTimer extends StatefulWidget {
  final Function(int) onTimerStop; // Devuelve el tiempo al detener el cronómetro

  const FloatingTimer({
    super.key,
    required this.onTimerStop,
  });

  @override
  FloatingTimerState createState() => FloatingTimerState();
}

class FloatingTimerState extends State<FloatingTimer> {
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer(); // Inicia automáticamente
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++; // Incrementamos los segundos
      });
    });
  }

  // Método para detener el temporizador y devolver el tiempo acumulado
  void stopTimer() {
    _timer?.cancel(); // Detenemos el temporizador
    widget.onTimerStop(_seconds); // Pasamos el tiempo acumulado a onTimerStop
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      right: 10,
      child: Opacity(
        opacity: 0.8,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Tiempo: $_seconds s', // Mostramos el tiempo actual
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
