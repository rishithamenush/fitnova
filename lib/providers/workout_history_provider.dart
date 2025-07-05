import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/models/workout_history.dart';

class WorkoutHistoryProvider extends ChangeNotifier {
  static const String _historyKey = 'workout_history';
  List<WorkoutHistory> _workoutHistory = [];
  WorkoutStatistics? _statistics;

  List<WorkoutHistory> get workoutHistory => _workoutHistory;
  WorkoutStatistics? get statistics => _statistics;

  WorkoutHistoryProvider() {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList(_historyKey);
    if (historyJson != null) {
      _workoutHistory = historyJson
          .map((json) => WorkoutHistory.fromJson(jsonDecode(json)))
          .toList();
      _updateStatistics();
      notifyListeners();
    }
  }

  void _updateStatistics() {
    _statistics = WorkoutStatistics.fromHistory(_workoutHistory);
  }

  Future<void> addWorkoutHistory(WorkoutHistory history) async {
    _workoutHistory.insert(0, history); // Add to beginning of list
    _updateStatistics();
    
    final prefs = await SharedPreferences.getInstance();
    final historyJson = _workoutHistory
        .map((history) => jsonEncode(history.toJson()))
        .toList();
    await prefs.setStringList(_historyKey, historyJson);
    
    notifyListeners();
  }

  Future<void> clearHistory() async {
    _workoutHistory.clear();
    _statistics = null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
    
    notifyListeners();
  }

  // Get statistics for a specific day
  WorkoutStatistics? getDayStatistics(String day) {
    final dayHistory = _workoutHistory
        .where((workout) => workout.day == day)
        .toList();
    return dayHistory.isEmpty ? null : WorkoutStatistics.fromHistory(dayHistory);
  }

  // Get the most recent workout for a specific day
  WorkoutHistory? getLastWorkoutForDay(String day) {
    try {
      return _workoutHistory.firstWhere(
        (workout) => workout.day == day,
      );
    } catch (e) {
      return null;
    }
  }

  // Get total workouts completed this week
  int getWorkoutsThisWeek() {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    return _workoutHistory
        .where((workout) => workout.completedAt.isAfter(weekStart))
        .length;
  }

  // Get total workouts completed this month
  int getWorkoutsThisMonth() {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    return _workoutHistory
        .where((workout) => workout.completedAt.isAfter(monthStart))
        .length;
  }
} 