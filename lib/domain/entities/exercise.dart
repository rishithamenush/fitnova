class Exercise {
  final int? id;
  final int workoutId;
  final String name;
  final int sets;
  final int reps;
  final double? weight;
  final bool isCompleted;

  Exercise({
    this.id,
    required this.workoutId,
    required this.name,
    required this.sets,
    required this.reps,
    this.weight,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workout_id': workoutId,
      'name': name,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'is_completed': isCompleted ? 1 : 0,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      workoutId: map['workout_id'],
      name: map['name'],
      sets: map['sets'],
      reps: map['reps'],
      weight: map['weight'],
      isCompleted: map['is_completed'] == 1,
    );
  }

  Exercise copyWith({
    int? id,
    int? workoutId,
    String? name,
    int? sets,
    int? reps,
    double? weight,
    bool? isCompleted,
  }) {
    return Exercise(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      name: name ?? this.name,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
} 