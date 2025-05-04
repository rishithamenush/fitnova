import '../../domain/models/workout_model.dart';
import '../../domain/repositories/workout_repository.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final List<WorkoutModel> _workouts = [
    WorkoutModel(
      day: 'Day 01',
      title: 'Chest & Triceps',
      warmup: 'Warm Up - 15 min',
      exercises: [
        ExerciseModel(name: 'Rope Pull over', sets: '10, 10, 10, 10'),
        ExerciseModel(name: 'In bench Press (Barbell)', sets: '10, 10, 8, 8'),
        ExerciseModel(name: 'In Dumble Press', sets: '8, 8, 8'),
        ExerciseModel(name: 'Flat Bench Press', sets: '10, 10, 8, 8'),
        ExerciseModel(name: 'Cable Fly', sets: '10, 10, 8, 8'),
        ExerciseModel(name: 'Decline Press', sets: '10, 10, 10'),
        ExerciseModel(name: 'Tricep Line Down', sets: '10, 10, 10'),
        ExerciseModel(name: 'Cable French (Rope)', sets: '10, 10, 10'),
        ExerciseModel(name: 'Dumble Kick Back', sets: '8, 8, 8'),
        ExerciseModel(name: 'Tricep Dips', sets: '8, 8, 8'),
      ],
    ),
    WorkoutModel(
      day: 'Day 02',
      title: 'Shoulders & Back',
      warmup: 'Warm Up - 15 min',
      exercises: [
        ExerciseModel(name: 'Dumble Shoulder Press', sets: '8, 8, 8'),
        ExerciseModel(name: 'Latteral Raise', sets: '8, 8, 8, 8'),
        ExerciseModel(name: 'Dumble Front Raise', sets: '8, 8, 8, 8'),
        ExerciseModel(name: 'Up Right Row', sets: '8, 8, 8, 8'),
        ExerciseModel(name: 'Lat Pull Down', sets: '10, 10, 10, 10'),
        ExerciseModel(name: 'Seated Cable Row', sets: '10, 10, 10, 10'),
        ExerciseModel(name: 'Bent over barbell row', sets: '8, 8, 8'),
        ExerciseModel(name: 'Dumble row', sets: '8, 8, 8'),
      ],
    ),
    WorkoutModel(
      day: 'Day 03',
      title: 'Legs & Biceps',
      warmup: 'Warm Up - 15 min',
      exercises: [
        ExerciseModel(name: 'Free Squat', sets: '8, 8, 8'),
        ExerciseModel(name: 'Full Squat', sets: '10, 10, 8, 8'),
        ExerciseModel(name: 'Dumble langust', sets: '8, 8, 8'),
        ExerciseModel(name: 'Sumo Squat', sets: '8, 8, 8, 8'),
        ExerciseModel(name: 'Smith Cart', sets: '15, 15, 15'),
        ExerciseModel(name: 'Long Bar Curll', sets: '8, 8, 8, 8'),
        ExerciseModel(name: 'Machine Precher Curll', sets: '8, 8, 8'),
        ExerciseModel(name: 'Harmmer Curll', sets: '8, 8, 8'),
        ExerciseModel(name: 'Forams', sets: '10, 10, 10, 10'),
      ],
    ),
  ];

  @override
  Future<List<WorkoutModel>> getWorkouts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _workouts;
  }

  @override
  Future<WorkoutModel> getWorkoutByDay(int day) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _workouts[day - 1];
  }
} 