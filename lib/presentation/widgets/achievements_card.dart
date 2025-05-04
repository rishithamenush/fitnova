import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitnova/config/app_config.dart';

class AchievementsCard extends StatelessWidget {
  final bool isSmallScreen;
  final List<Map<String, dynamic>> achievements;

  const AchievementsCard({
    super.key,
    required this.isSmallScreen,
    required this.achievements,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 10 : 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Achievements',
            style: GoogleFonts.poppins(
              fontSize: isSmallScreen ? 16 : 18,
              fontWeight: FontWeight.bold,
              color: const Color(AppConfig.primaryColor),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                final achievement = achievements[index];
                return Container(
                  width: 120,
                  margin: EdgeInsets.only(
                    right: index < achievements.length - 1 ? 15 : 0,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        achievement['icon'],
                        color: const Color(AppConfig.primaryColor),
                        size: 24,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        achievement['title'],
                        style: GoogleFonts.poppins(
                          fontSize: isSmallScreen ? 10 : 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: LinearProgressIndicator(
                          value: achievement['progress'],
                          backgroundColor: const Color(AppConfig.primaryColor).withOpacity(0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            const Color(AppConfig.primaryColor),
                          ),
                          minHeight: 4,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 