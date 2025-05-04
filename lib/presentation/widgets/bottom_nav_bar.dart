import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fitnova/config/app_config.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.grey,
            activeColor: Color(AppConfig.primaryColor),
            tabBackgroundColor: Color(AppConfig.primaryColor).withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            gap: 8,
            onTabChange: onTap,
            selectedIndex: currentIndex,
            tabs: const [
              GButton(
                icon: FontAwesomeIcons.house,
                text: 'Home',
                iconColor: Colors.grey,
                textColor: Color(AppConfig.primaryColor),
              ),
              GButton(
                icon: FontAwesomeIcons.dumbbell,
                text: 'Workout',
                iconColor: Colors.grey,
                textColor: Color(AppConfig.primaryColor),
              ),
              GButton(
                icon: FontAwesomeIcons.chartLine,
                text: 'Progress',
                iconColor: Colors.grey,
                textColor: Color(AppConfig.primaryColor),
              ),
              GButton(
                icon: FontAwesomeIcons.gear,
                text: 'Settings',
                iconColor: Colors.grey,
                textColor: Color(AppConfig.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}