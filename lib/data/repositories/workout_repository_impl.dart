import '../../domain/entities/exercise.dart';
import '../../domain/models/workout_model.dart';
import '../../domain/repositories/workout_repository.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final List<WorkoutModel> _workouts = [
    WorkoutModel(
      day: 'Day 01',
      title: 'Chest & Triceps',
      warmup: 'Warm Up - 15 min',
      exercises: [
        Exercise(
          workoutId: 1,
          name: 'Rope Pull over',
          sets: 4,
          reps: 10,
          instructions: 'Stand with feet shoulder-width apart. Hold the rope with both hands and pull it down in a controlled motion.',
        ),
        Exercise(
          workoutId: 1,
          name: 'In bench Press (Barbell)',
          sets: 4,
          reps: 10,
          instructions: 'Lie on an incline bench. Grip the barbell slightly wider than shoulder-width and lower it to your chest.',
        ),
        Exercise(
          workoutId: 1,
          name: 'In Dumble Press',
          sets: 3,
          reps: 8,
          instructions: 'Lie on an incline bench. Hold dumbbells at shoulder level and press them up until arms are extended.',
        ),
        Exercise(
          workoutId: 1,
          name: 'Flat Bench Press',
          sets: 4,
          reps: 10,
          instructions: 'Lie on a flat bench. Grip the barbell at shoulder width and lower it to your chest before pressing up.',
        ),
        Exercise(
          workoutId: 1,
          name: 'Cable Fly',
          sets: 4,
          reps: 10,
          instructions: 'Stand between two cable machines. With arms extended, bring hands together in front of your chest.',
        ),
        Exercise(
          workoutId: 1,
          name: 'Decline Press',
          sets: 3,
          reps: 10,
          instructions: 'Lie on a decline bench. Grip the barbell and lower it to your lower chest before pressing up.',
        ),
        Exercise(
          workoutId: 1,
          name: 'Tricep Line Down',
          sets: 3,
          reps: 10,
          instructions: 'Stand facing a high pulley. Push the rope down until your arms are fully extended.',
        ),
        Exercise(
          workoutId: 1,
          name: 'Cable French (Rope)',
          sets: 3,
          reps: 10,
          instructions: 'Stand facing away from a high pulley. Extend arms overhead and pull the rope down behind your head.',
        ),
        Exercise(
          workoutId: 1,
          name: 'Dumble Kick Back',
          sets: 3,
          reps: 8,
          instructions: 'Bend forward at the waist. Hold dumbbell in one hand and extend your arm back.',
        ),
        Exercise(
          workoutId: 1,
          name: 'Tricep Dips',
          sets: 3,
          reps: 8,
          instructions: 'Support yourself on parallel bars. Lower your body by bending your arms, then push back up.',
        ),
      ],
    ),
    WorkoutModel(
      day: 'Day 02',
      title: 'Shoulders & Back',
      warmup: 'Warm Up - 15 min',
      exercises: [
        Exercise(
          workoutId: 2,
          name: 'Dumble Shoulder Press',
          sets: 3,
          reps: 8,
          instructions: 'Sit with back supported. Hold dumbbells at shoulder level and press them overhead.',
        ),
        Exercise(
          workoutId: 2,
          name: 'Latteral Raise',
          sets: 4,
          reps: 8,
          instructions: 'Stand with dumbbells at your sides. Raise arms out to the sides until parallel to the floor.',
        ),
        Exercise(
          workoutId: 2,
          name: 'Dumble Front Raise',
          sets: 4,
          reps: 8,
          instructions: 'Stand with dumbbells in front of thighs. Raise arms forward until parallel to the floor.',
        ),
        Exercise(
          workoutId: 2,
          name: 'Up Right Row',
          sets: 4,
          reps: 8,
          instructions: 'Stand with barbell in front of thighs. Pull the bar up along your body to chin level.',
        ),
        Exercise(
          workoutId: 2,
          name: 'Lat Pull Down',
          sets: 4,
          reps: 10,
          instructions: 'Sit at a lat pulldown machine. Pull the bar down to your upper chest.',
        ),
        Exercise(
          workoutId: 2,
          name: 'Seated Cable Row',
          sets: 4,
          reps: 10,
          instructions: 'Sit at a cable row machine. Pull the handle to your lower chest while keeping back straight.',
        ),
        Exercise(
          workoutId: 2,
          name: 'Bent over barbell row',
          sets: 3,
          reps: 8,
          instructions: 'Bend at waist with barbell in hands. Pull the bar to your lower chest.',
        ),
        Exercise(
          workoutId: 2,
          name: 'Dumble row',
          sets: 3,
          reps: 8,
          instructions: 'Place one hand and knee on bench. Hold dumbbell in other hand and row it to your side.',
        ),
      ],
    ),
    WorkoutModel(
      day: 'Day 03',
      title: 'Legs & Biceps',
      warmup: 'Warm Up - 15 min',
      exercises: [
        Exercise(
          workoutId: 3,
          name: 'Free Squat',
          sets: 3,
          reps: 8,
          instructions: 'Stand with feet shoulder-width apart. Lower body by bending knees and hips.',
        ),
        Exercise(
          workoutId: 3,
          name: 'Full Squat',
          sets: 4,
          reps: 10,
          instructions: 'Stand with feet wider than shoulder-width. Lower body until thighs are parallel to floor.',
        ),
        Exercise(
          workoutId: 3,
          name: 'Dumble langust',
          sets: 3,
          reps: 8,
          instructions: 'Stand with dumbbells at sides. Step forward and lower back knee toward floor.',
        ),
        Exercise(
          workoutId: 3,
          name: 'Sumo Squat',
          sets: 4,
          reps: 8,
          instructions: 'Stand with feet wide and toes pointed out. Lower body while keeping chest up.',
        ),
        Exercise(
          workoutId: 3,
          name: 'Smith Cart',
          sets: 3,
          reps: 15,
          instructions: 'Stand in Smith machine. Place feet forward and perform squats with controlled movement.',
        ),
        Exercise(
          workoutId: 3,
          name: 'Long Bar Curll',
          sets: 4,
          reps: 8,
          instructions: 'Stand with barbell at thighs. Curl the bar up while keeping elbows close to body.',
        ),
        Exercise(
          workoutId: 3,
          name: 'Machine Precher Curll',
          sets: 3,
          reps: 8,
          instructions: 'Sit at preacher curl machine. Curl the weight up while keeping upper arms on pad.',
        ),
        Exercise(
          workoutId: 3,
          name: 'Harmmer Curll',
          sets: 3,
          reps: 8,
          instructions: 'Stand with dumbbells at sides. Curl weights up while keeping palms facing each other.',
        ),
        Exercise(
          workoutId: 3,
          name: 'Forams',
          sets: 4,
          reps: 10,
          instructions: 'Stand with dumbbells at sides. Curl weights up while rotating wrists outward.',
        ),
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