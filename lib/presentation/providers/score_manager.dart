import 'package:shared_preferences/shared_preferences.dart';

class ScoreManager {
  static const String _easyHighScoreKey = 'easy_high_score';
  static const String _normalHighScoreKey = 'normal_high_score';
  static const String _hardHighScoreKey = 'hard_high_score';

  // Guardar la puntuación más alta para un nivel de dificultad
  static Future<void> saveHighScore(String difficulty, int score) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (difficulty) {
      case 'easy':
        prefs.setInt(_easyHighScoreKey, score);
        break;
      case 'normal':
        prefs.setInt(_normalHighScoreKey, score);
        break;
      case 'hard':
        prefs.setInt(_hardHighScoreKey, score);
        break;
    }
  }

  // Recuperar la puntuación más alta para un nivel de dificultad
  static Future<int> getHighScore(String difficulty) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (difficulty) {
      case 'easy':
        return prefs.getInt(_easyHighScoreKey) ?? 0;
      case 'normal':
        return prefs.getInt(_normalHighScoreKey) ?? 0;
      case 'hard':
        return prefs.getInt(_hardHighScoreKey) ?? 0;
      default:
        return 0;
    }
  }
}
