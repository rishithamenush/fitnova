class WorkoutProgress {
  final int dayNumber;
  final int currentExerciseIndex;
  final int currentSet;
  final DateTime lastUpdated;
  final bool isCompleted;
  final List<int> completedSets; // Store which sets are completed for each exercise

  WorkoutProgress({
    required this.dayNumber,
    required this.currentExerciseIndex,
    required this.currentSet,
    required this.lastUpdated,
    this.isCompleted = false,
    required this.completedSets,
  });

  Map<String, dynamic> toJson() {
    return {
      'dayNumber': dayNumber,
      'currentExerciseIndex': currentExerciseIndex,
      'currentSet': currentSet,
      'lastUpdated': lastUpdated.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0,
      'completedSets': completedSets,
    };
  }

  factory WorkoutProgress.fromJson(Map<String, dynamic> json) {
    return WorkoutProgress(
      dayNumber: json['dayNumber'],
      currentExerciseIndex: json['currentExerciseIndex'],
      currentSet: json['currentSet'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
      isCompleted: json['isCompleted'] == 1,
      completedSets: List<int>.from(json['completedSets']),
    );
  }

  WorkoutProgress copyWith({
    int? dayNumber,
    int? currentExerciseIndex,
    int? currentSet,
    DateTime? lastUpdated,
    bool? isCompleted,
    List<int>? completedSets,
  }) {
    return WorkoutProgress(
      dayNumber: dayNumber ?? this.dayNumber,
      currentExerciseIndex: currentExerciseIndex ?? this.currentExerciseIndex,
      currentSet: currentSet ?? this.currentSet,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isCompleted: isCompleted ?? this.isCompleted,
      completedSets: completedSets ?? this.completedSets,
    );
  }
} 