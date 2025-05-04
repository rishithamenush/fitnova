import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitnova/config/app_config.dart';

class QuickActionsCard extends StatelessWidget {
  final bool isSmallScreen;
  final bool isMediumScreen;
  final bool isLargeScreen;

  const QuickActionsCard({
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildQuickAction(
            icon: Icons.fitness_center,
            label: 'Start Workout',
            color: const Color(AppConfig.primaryColor),
            isSmallScreen: isSmallScreen,
          ),
          _buildQuickAction(
            icon: Icons.timer,
            label: 'Quick Timer',
            color: const Color(AppConfig.successColor),
            isSmallScreen: isSmallScreen,
          ),
          _buildQuickAction(
            icon: Icons.analytics,
            label: 'Progress',
            color: const Color(AppConfig.warningColor),
            isSmallScreen: isSmallScreen,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required Color color,
    required bool isSmallScreen,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(isSmallScreen ? 12 : 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: isSmallScreen ? 20 : 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: isSmallScreen ? 10 : 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 