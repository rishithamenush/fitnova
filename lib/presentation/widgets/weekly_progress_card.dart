import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitnova/config/app_config.dart';

class WeeklyProgressCard extends StatelessWidget {
  final bool isSmallScreen;
  final bool isMediumScreen;
  final bool isLargeScreen;

  const WeeklyProgressCard({
    super.key,
    required this.isSmallScreen,
    required this.isMediumScreen,
    required this.isLargeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 10 : isMediumScreen ? 15 : 20,
      ),
      padding: EdgeInsets.all(isSmallScreen ? 15 : isMediumScreen ? 18 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Weekly Progress',
                style: GoogleFonts.poppins(
                  fontSize: isSmallScreen ? 16 : isMediumScreen ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(AppConfig.primaryColor),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(AppConfig.primaryColor).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Week 3',
                  style: GoogleFonts.poppins(
                    fontSize: isSmallScreen ? 12 : 14,
                    color: const Color(AppConfig.primaryColor),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: LinearProgressIndicator(
              value: 0.7,
              backgroundColor: const Color(AppConfig.primaryColor).withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(
                const Color(AppConfig.primaryColor),
              ),
              minHeight: 12,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'You\'re 70% through your weekly goal',
                style: GoogleFonts.poppins(
                  fontSize: isSmallScreen ? 12 : isMediumScreen ? 13 : 14,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                '2,100 / 3,000',
                style: GoogleFonts.poppins(
                  fontSize: isSmallScreen ? 12 : isMediumScreen ? 13 : 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(AppConfig.primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 