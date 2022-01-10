import 'package:shared_preferences/shared_preferences.dart';

class GameLevelRepository {
  String easy = 'EASY';
  String difficult = 'DIFFICULT';
  String selectedLevel = 'Selected Level';

  Future<int> levelsCreated() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getKeys().length;
  }

  Future<void> levelsCreatedAndInitialized() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(selectedLevel, difficult);
  }

  Future<String?> getLevel() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(selectedLevel);
  }

  Future<void> changeLevel(String changed) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(selectedLevel, changed);
  }

  Future<void> clear() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.remove(selectedLevel);
  }
}
