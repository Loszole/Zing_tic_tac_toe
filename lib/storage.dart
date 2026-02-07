import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StatsStorage {
  static const String _key = 'tic_tac_toe_stats';

  static Future<Map<String, dynamic>> loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return {};
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  static Future<void> saveStats(Map<String, dynamic> stats) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, json.encode(stats));
  }

  static Future<void> resetStats() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
