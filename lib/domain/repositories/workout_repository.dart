import '../models/workout_model.dart';

abstract class WorkoutRepository {
  Future<List<WorkoutModel>> getWorkouts();
  Future<WorkoutModel> getWorkoutByDay(int day);
} 