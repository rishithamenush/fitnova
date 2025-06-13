import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../domain/entities/exercise.dart';
import '../../domain/models/workout_model.dart';
import '../../providers/settings_provider.dart';
import '../../providers/workout_progress_provider.dart';

class ActiveWorkoutScreen extends StatefulWidget {
  final WorkoutModel workout;
  final Color categoryColor;
  final int? initialExerciseIndex;
  final int? initialSet;
  final List<int>? completedSets;

  const ActiveWorkoutScreen({
    super.key,
    required this.workout,
    required this.categoryColor,
    this.initialExerciseIndex,
    this.initialSet,
    this.completedSets,
  });

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  late int _currentExerciseIndex;
  late int _currentSet;
  int _remainingTime = 0;
  bool _isResting = false;
  bool _isCompleted = false;
  Timer? _restTimer;
  late List<int> _completedSets;

  Exercise get _currentExercise => widget.workout.exercises[_currentExerciseIndex];

  @override
  void initState() {
    super.initState();
    _currentExerciseIndex = widget.initialExerciseIndex ?? 0;
    _currentSet = widget.initialSet ?? 1;
    _completedSets = widget.completedSets ?? List.filled(widget.workout.exercises.length, 0);
  }

  @override
  void dispose() {
    _restTimer?.cancel();
    super.dispose();
  }

  void _startRestTimer() {
    final restTime = context.read<SettingsProvider>().restTime;
    setState(() {
      _isResting = true;
      _remainingTime = restTime;
    });

    _restTimer?.cancel();
    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          timer.cancel();
          setState(() {
            _isResting = false;
          });
        }
      });
    });
  }

  Future<void> _updateProgress() async {
    final progressProvider = context.read<WorkoutProgressProvider>();
    await progressProvider.updateProgress(
      currentExerciseIndex: _currentExerciseIndex,
      currentSet: _currentSet,
      isCompleted: _isCompleted,
      completedSets: _completedSets,
    );
  }

  void _completeSet() async {
    // Mark current set as completed
    _completedSets[_currentExerciseIndex] = _currentSet;

    if (_currentSet < _currentExercise.sets) {
      setState(() {
        _currentSet++;
        _startRestTimer();
      });
    } else if (_currentExerciseIndex < widget.workout.exercises.length - 1) {
      setState(() {
        _currentExerciseIndex++;
        _currentSet = 1;
        _startRestTimer();
      });
    } else {
      setState(() {
        _isCompleted = true;
      });
    }

    await _updateProgress();
  }

  @override
  Widget build(BuildContext context) {
    if (_isCompleted) {
      // Clear progress when workout is completed
      context.read<WorkoutProgressProvider>().clearProgress();
      return _buildCompletionScreen();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: SafeArea(
        child: Column(
          children: [
            _buildProgressBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildExerciseCard(),
                    const SizedBox(height: 24),
                    _buildInstructionsCard(),
                    if (_isResting) _buildRestTimer(),
                  ],
                ),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = (_currentExerciseIndex + _currentSet / _currentExercise.sets) /
        widget.workout.exercises.length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Exercise ${_currentExerciseIndex + 1}/${widget.workout.exercises.length}',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                'Set $_currentSet/${_currentExercise.sets}',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: widget.categoryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(widget.categoryColor),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: widget.categoryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.fitness_center,
                  color: widget.categoryColor,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentExercise.name,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_currentExercise.sets} sets × ${_currentExercise.reps} reps',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSetProgressIndicator(),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildSetProgressIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Set Progress',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            _currentExercise.sets,
            (index) {
              final isCompleted = index < _currentSet - 1;
              final isCurrent = index == _currentSet - 1;
              
              return Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? widget.categoryColor
                      : isCurrent
                          ? widget.categoryColor.withOpacity(0.2)
                          : Colors.grey[200],
                  shape: BoxShape.circle,
                  border: isCurrent
                      ? Border.all(
                          color: widget.categoryColor,
                          width: 2,
                        )
                      : null,
                ),
                child: Center(
                  child: isCompleted
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        )
                      : Text(
                          '${index + 1}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isCurrent
                                ? widget.categoryColor
                                : Colors.grey[600],
                          ),
                        ),
                ),
              ).animate(
                target: isCurrent ? 1 : 0,
              ).scale(
                duration: 400.ms,
                curve: Curves.easeOutBack,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: widget.categoryColor,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Instructions',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _currentExercise.instructions,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildRestTimer() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: widget.categoryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Text(
              'Rest Time',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: widget.categoryColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '$_remainingTime',
              style: GoogleFonts.poppins(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: widget.categoryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'seconds',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideY(begin: 0.3, end: 0),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: _isResting ? null : _completeSet,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.categoryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                _isResting 
                    ? 'Resting...' 
                    : _currentSet == _currentExercise.sets 
                        ? 'Complete Exercise' 
                        : 'Complete Set',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: widget.categoryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                size: 100,
                color: widget.categoryColor,
              ),
            ).animate().scale(duration: 600.ms),
            const SizedBox(height: 32),
            Text(
              'Workout Completed!',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
            const SizedBox(height: 16),
            Text(
              'Great job! You\'ve completed all exercises.',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.categoryColor,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Back to Workout',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
          ],
        ),
      ),
    );
  }
} 