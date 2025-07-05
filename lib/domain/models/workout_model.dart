import '../entities/exercise.dart';

class WorkoutModel {
  final String id;
  final String day;
  final String title;
  final String description;
  final String warmup;
  final List<Exercise> exercises;
  final String category;
  final String difficulty;
  final String imageUrl;

  WorkoutModel({
    String? id,
    required this.day,
    required this.title,
    required this.warmup,
    required this.exercises,
    this.description = '',
    this.category = '',
    this.difficulty = '',
    this.imageUrl = '',
  }) : id = id ?? day;

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      id: json['id'],
      day: json['day'],
      title: json['title'],
      description: json['description'] ?? '',
      warmup: json['warmup'] ?? '',
      exercises: (json['exercises'] as List)
          .map((e) => Exercise.fromMap(e))
          .toList(),
      category: json['category'] ?? '',
      difficulty: json['difficulty'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'title': title,
      'description': description,
      'warmup': warmup,
      'exercises': exercises.map((e) => e.toMap()).toList(),
      'category': category,
      'difficulty': difficulty,
      'imageUrl': imageUrl,
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