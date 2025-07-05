class WorkoutHistory {
  final String day;
  final String workoutTitle;
  final DateTime completedAt;
  final int totalExercises;
  final int totalSets;
  final int totalReps;
  final List<ExerciseHistory> exercises;

  WorkoutHistory({
    required this.day,
    required this.workoutTitle,
    required this.completedAt,
    required this.totalExercises,
    required this.totalSets,
    required this.totalReps,
    required this.exercises,
  });

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'workoutTitle': workoutTitle,
      'completedAt': completedAt.toIso8601String(),
      'totalExercises': totalExercises,
      'totalSets': totalSets,
      'totalReps': totalReps,
      'exercises': exercises.map((e) => e.toJson()).toList(),
    };
  }

  factory WorkoutHistory.fromJson(Map<String, dynamic> json) {
    return WorkoutHistory(
      day: json['day'],
      workoutTitle: json['workoutTitle'],
      completedAt: DateTime.parse(json['completedAt']),
      totalExercises: json['totalExercises'],
      totalSets: json['totalSets'],
      totalReps: json['totalReps'],
      exercises: (json['exercises'] as List)
          .map((e) => ExerciseHistory.fromJson(e))
          .toList(),
    );
  }
}

class ExerciseHistory {
  final String name;
  final int sets;
  final int reps;
  final bool isCompleted;

  ExerciseHistory({
    required this.name,
    required this.sets,
    required this.reps,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sets': sets,
      'reps': reps,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory ExerciseHistory.fromJson(Map<String, dynamic> json) {
    return ExerciseHistory(
      name: json['name'],
      sets: json['sets'],
      reps: json['reps'],
      isCompleted: json['isCompleted'] == 1,
    );
  }
}

class WorkoutStatistics {
  final int totalWorkouts;
  final int totalExercises;
  final int totalSets;
  final int totalReps;
  final List<WorkoutHistory> recentWorkouts;
  final Map<String, int> workoutsByDay; // Day -> count

  WorkoutStatistics({
    required this.totalWorkouts,
    required this.totalExercises,
    required this.totalSets,
    required this.totalReps,
    required this.recentWorkouts,
    required this.workoutsByDay,
  });

  factory WorkoutStatistics.fromHistory(List<WorkoutHistory> history) {
    final workoutsByDay = <String, int>{};
    var totalExercises = 0;
    var totalSets = 0;
    var totalReps = 0;

    for (var workout in history) {
      totalExercises += workout.totalExercises;
      totalSets += workout.totalSets;
      totalReps += workout.totalReps;
      
      workoutsByDay[workout.day] = (workoutsByDay[workout.day] ?? 0) + 1;
    }

    return WorkoutStatistics(
      totalWorkouts: history.length,
      totalExercises: totalExercises,
      totalSets: totalSets,
      totalReps: totalReps,
      recentWorkouts: history.take(5).toList(), // Last 5 workouts
      workoutsByDay: workoutsByDay,
    );
  }
} 