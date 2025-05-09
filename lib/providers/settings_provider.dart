import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsProvider extends ChangeNotifier {
  static const String _restTimeKey = 'rest_time';
  int _restTime = 60; // Default 60 seconds

  SettingsProvider() {
    _loadSettings();
  }

  int get restTime => _restTime;

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _restTime = prefs.getInt(_restTimeKey) ?? 60;
    notifyListeners();
  }

  Future<void> setRestTime(int seconds) async {
    if (seconds < 0) return;
    _restTime = seconds;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_restTimeKey, seconds);
    notifyListeners();
  }
} 