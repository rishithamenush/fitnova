import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitnova/config/app_config.dart';


import 'home_widgets.dart';

class TodayWorkoutCard extends StatelessWidget {
  final bool isSmallScreen;
  final bool isMediumScreen;
  final bool isLargeScreen;

  const TodayWorkoutCard({
    super.key,
    required this.isSmallScreen,
    required this.isMediumScreen,
    required this.isLargeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 10 : isMediumScreen ? 15 : 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today\'s Workout',
                style: GoogleFonts.poppins(
                  fontSize: isSmallScreen ? 16 : isMediumScreen ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(AppConfig.primaryColor),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: GoogleFonts.poppins(
                    fontSize: isSmallScreen ? 12 : 14,
                    color: const Color(AppConfig.primaryColor),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          WorkoutCard(
            title: 'Upper Body Strength',
            description: 'Focus on chest, shoulders, and arms',
            imagePath: 'assets/images/legsWorkout.png',
            icon: Icons.fitness_center,
            onTap: () {},
          ),
          WorkoutCard(
            title: 'Core Crusher',
            description: 'Intense ab workout for a strong core',
            imagePath: 'assets/images/armsWorkout.png',
            icon: Icons.sports_gymnastics,
            onTap: () {},
          ),
        ],
      ),
    );
  }
} 