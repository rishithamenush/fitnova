import '../entities/exercise.dart';

class WorkoutModel {
  final String day;
  final String title;
  final String warmup;
  final List<Exercise> exercises;

  WorkoutModel({
    required this.day,
    required this.title,
    required this.warmup,
    required this.exercises,
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      day: json['day'],
      title: json['title'],
      warmup: json['warmup'],
      exercises: (json['exercises'] as List)
          .map((e) => Exercise.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'title': title,
      'warmup': warmup,
      'exercises': exercises.map((e) => e.toMap()).toList(),
    };
  }
}

class ExerciseModel {
  final String name;
  final String sets;

  ExerciseModel({
    required this.name,
    required this.sets,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      name: json['name'],
      sets: json['sets'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sets': sets,
    };
  }
} 