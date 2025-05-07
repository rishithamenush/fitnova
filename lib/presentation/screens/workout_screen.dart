import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../domain/models/workout_model.dart';
import '../../domain/repositories/workout_repository.dart';
import 'workout_detail_screen.dart';

class WorkoutScreen extends StatefulWidget {
  final WorkoutRepository repository;

  const WorkoutScreen({
    super.key,
    required this.repository,
  });

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isLoading = true;
  List<WorkoutModel> _workouts = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    final workouts = await widget.repository.getWorkouts();
    if (mounted) {
      setState(() {
        _workouts = workouts;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getImagePath(String title) {
    switch (title.toLowerCase()) {
      case 'chest & triceps':
        return 'assets/images/chestWorkout.png';
      case 'shoulders & back':
        return 'assets/images/armsWorkout.png';
      case 'legs & biceps':
        return 'assets/images/legsWorkout.png';
      default:
        return 'assets/images/gymWorkout.png';
    }
  }

  String _getWorkoutIcon(String title) {
    switch (title.toLowerCase()) {
      case 'chest & triceps':
        return 'assets/icons/chest_.png';
      case 'shoulders & back':
        return 'assets/icons/shoulders_.png';
      case 'legs & biceps':
        return 'assets/icons/legs_.png';
      default:
        return 'assets/icons/chest_.png';
    }
  }

  Color _getColorForDay(int day) {
    switch (day) {
      case 1:
        return const Color(0xFF2196F3);
      case 2:
        return const Color(0xFFE91E63);
      case 3:
        return const Color(0xFF4CAF50);
      default:
        return const Color(0xFF2196F3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF2196F3),
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your 3-Day Split',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
                  const SizedBox(height: 8),
                  Text(
                    'Select a day to view your workout routine',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideY(begin: 0.3, end: 0),
                ],
              ),
              titlePadding: const EdgeInsets.only(left: 20, bottom: 20),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/gymWorkout.png',
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.3),
                    colorBlendMode: BlendMode.darken,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: -20,
                    bottom: -20,
                    child: Icon(
                      Icons.fitness_center,
                      size: 150,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    AnimatedBuilder(
                      animation: _fadeAnimation,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child: child,
                        );
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _workouts.length,
                        itemBuilder: (context, index) {
                          final workout = _workouts[index];
                          final dayNumber = int.parse(workout.day.split(' ')[1]);
                          final color = _getColorForDay(dayNumber);
                          
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Hero(
                              tag: 'workout-${workout.day}',
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WorkoutDetailScreen(
                                          category: '${workout.day} - ${workout.title}',
                                          categoryColor: color,
                                          dayNumber: dayNumber,
                                          repository: widget.repository,
                                        ),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(24),
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      boxShadow: [
                                        BoxShadow(
                                          color: color.withOpacity(0.4),
                                          blurRadius: 15,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        // Background Image
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(24),
                                          child: Image.asset(
                                            _getImagePath(workout.title),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                            color: Colors.black.withOpacity(0.2),
                                            colorBlendMode: BlendMode.darken,
                                          ),
                                        ),
                                        // Gradient Overlay
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(24),
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                color.withOpacity(0.9),
                                                color.withOpacity(0.3),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Content
                                        Padding(
                                          padding: const EdgeInsets.all(24.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.all(12),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white.withOpacity(0.2),
                                                      borderRadius: BorderRadius.circular(16),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black.withOpacity(0.1),
                                                          blurRadius: 8,
                                                          offset: const Offset(0, 4),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Image.asset(
                                                      _getWorkoutIcon(workout.title),
                                                      width: 32,
                                                      height: 32,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          workout.day,
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 28,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.white,
                                                            shadows: [
                                                              Shadow(
                                                                color: Colors.black.withOpacity(0.3),
                                                                offset: const Offset(0, 2),
                                                                blurRadius: 4,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          workout.title,
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 20,
                                                            color: Colors.white.withOpacity(0.9),
                                                            shadows: [
                                                              Shadow(
                                                                color: Colors.black.withOpacity(0.2),
                                                                offset: const Offset(0, 1),
                                                                blurRadius: 2,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white.withOpacity(0.2),
                                                      borderRadius: BorderRadius.circular(20),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black.withOpacity(0.1),
                                                          blurRadius: 8,
                                                          offset: const Offset(0, 4),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.fitness_center,
                                                          color: Colors.white,
                                                          size: 16,
                                                        ),
                                                        const SizedBox(width: 4),
                                                        Text(
                                                          '${workout.exercises.length} Exercises',
                                                          style: GoogleFonts.poppins(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white.withOpacity(0.2),
                                                      borderRadius: BorderRadius.circular(20),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black.withOpacity(0.1),
                                                          blurRadius: 8,
                                                          offset: const Offset(0, 4),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'View Details',
                                                          style: GoogleFonts.poppins(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 8),
                                                        const Icon(
                                                          Icons.arrow_forward,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ).animate(delay: (200 * index).ms).fadeIn(duration: 600.ms).slideX(begin: 0.2, end: 0),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 