import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitnova/config/app_config.dart';
import 'package:fitnova/presentation/widgets/home_widgets.dart';
import 'package:fitnova/presentation/widgets/bottom_nav_bar.dart';
import 'package:fitnova/presentation/widgets/motivational_quote_card.dart';
import 'package:fitnova/presentation/widgets/workout_streak_card.dart';
import 'package:fitnova/presentation/widgets/daily_progress_card.dart';
import 'package:fitnova/presentation/widgets/achievements_card.dart';
import 'package:fitnova/presentation/widgets/weekly_progress_card.dart';
import 'package:fitnova/presentation/widgets/today_workout_card.dart';
import 'package:fitnova/presentation/widgets/quick_actions_card.dart';
import 'package:fitnova/presentation/screens/workout_screen.dart';
import '../../data/repositories/workout_repository_impl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final ScrollController _scrollController = ScrollController();
  
  // Mock data for new features
  final String _motivationalQuote = "The only bad workout is the one that didn't happen";
  final String _quoteAuthor = "Unknown";
  final int _workoutStreak = 7;
  final List<Map<String, dynamic>> _achievements = [
    {'icon': Icons.fitness_center, 'title': 'First Workout', 'progress': 1.0},
    {'icon': Icons.timer, 'title': 'Consistency', 'progress': 0.7},
    {'icon': Icons.local_fire_department, 'title': 'Calorie Master', 'progress': 0.5},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 1) { // Assuming 1 is the index for workouts
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkoutScreen(
              repository: WorkoutRepositoryImpl(),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;
    final isMediumScreen = screenSize.width >= 360 && screenSize.width < 600;
    final isLargeScreen = screenSize.width >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: Stack(
        children: [
          // Background Design
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(AppConfig.primaryColor).withOpacity(0.2),
                    const Color(AppConfig.primaryColor).withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(AppConfig.primaryColor).withOpacity(0.15),
                    const Color(AppConfig.primaryColor).withOpacity(0.05),
                  ],
                ),
              ),
            ),
          ),
          // Main content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Fixed HomeHeader
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: _HomeHeaderDelegate(),
              ),

              // Scrollable body
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: MotivationalQuoteCard(
                          quote: _motivationalQuote,
                          author: _quoteAuthor,
                          isSmallScreen: isSmallScreen,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: DailyProgressCard(
                          isSmallScreen: isSmallScreen,
                          isMediumScreen: isMediumScreen,
                          isLargeScreen: isLargeScreen,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: WorkoutStreakCard(
                          streakDays: _workoutStreak,
                          isSmallScreen: isSmallScreen,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: QuickActionsCard(
                          isSmallScreen: isSmallScreen,
                          isMediumScreen: isMediumScreen,
                          isLargeScreen: isLargeScreen,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: AchievementsCard(
                          isSmallScreen: isSmallScreen,
                          achievements: _achievements,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: TodayWorkoutCard(
                          isSmallScreen: isSmallScreen,
                          isMediumScreen: isMediumScreen,
                          isLargeScreen: isLargeScreen,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: WeeklyProgressCard(
                          isSmallScreen: isSmallScreen,
                          isMediumScreen: isMediumScreen,
                          isLargeScreen: isLargeScreen,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          ),
        ),
      ),
    );
  }
}

// HomeHeader delegate
class _HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const HomeHeader();
  }

  @override
  double get maxExtent => 180;

  @override
  double get minExtent => 180;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
