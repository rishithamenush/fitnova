import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/models/workout_progress.dart';

class WorkoutProgressProvider extends ChangeNotifier {
  static const String _progressKey = 'workout_progress';
  WorkoutProgress? _currentProgress;

  WorkoutProgress? get currentProgress => _currentProgress;

  WorkoutProgressProvider() {
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final progressJson = prefs.getString(_progressKey);
    if (progressJson != null) {
      _currentProgress = WorkoutProgress.fromJson(json.decode(progressJson));
      notifyListeners();
    }
  }

  Future<void> saveProgress(WorkoutProgress progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_progressKey, json.encode(progress.toJson()));
    _currentProgress = progress;
    notifyListeners();
  }

  Future<void> startNewWorkout(int dayNumber, int totalExercises) async {
    final progress = WorkoutProgress(
      dayNumber: dayNumber,
      currentExerciseIndex: 0,
      currentSet: 1,
      lastUpdated: DateTime.now(),
      completedSets: List.filled(totalExercises, 0), // Initialize with zeros
    );
    await saveProgress(progress);
  }

  Future<void> updateProgress({
    int? currentExerciseIndex,
    int? currentSet,
    bool? isCompleted,
    List<int>? completedSets,
  }) async {
    if (_currentProgress == null) return;

    final updatedProgress = _currentProgress!.copyWith(
      currentExerciseIndex: currentExerciseIndex,
      currentSet: currentSet,
      lastUpdated: DateTime.now(),
      isCompleted: isCompleted,
      completedSets: completedSets,
    );

    await saveProgress(updatedProgress);
  }

  Future<void> clearProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_progressKey);
    _currentProgress = null;
    notifyListeners();
  }

  bool hasActiveWorkout(int dayNumber) {
    return _currentProgress != null && 
           _currentProgress!.dayNumber == dayNumber && 
           !_currentProgress!.isCompleted;
  }
} 