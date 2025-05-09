import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitnova/config/app_config.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../providers/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  bool _darkMode = false;
  bool _notifications = true;
  bool _soundEffects = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildSection(
                title: 'Workout Settings',
                children: [
                  _buildRestTimeSetting(context, settings),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildRestTimeSetting(BuildContext context, SettingsProvider settings) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rest Time',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Time between sets',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${settings.restTime}s',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Slider(
            value: settings.restTime.toDouble(),
            min: 0,
            max: 180,
            divisions: 36,
            label: '${settings.restTime}s',
            onChanged: (value) {
              settings.setRestTime(value.toInt());
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0s',
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                ),
              ),
              Text(
                '180s',
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 120,
      borderRadius: 20,
      blur: 10,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(AppConfig.primaryColor).withOpacity(0.1),
          Color(AppConfig.primaryColor).withOpacity(0.05),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(AppConfig.primaryColor).withOpacity(0.5),
          Color(AppConfig.primaryColor).withOpacity(0.2),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(AppConfig.accentColor),
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                'assets/images/profile.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rishitha Menusha',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConfig.textColor),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Premium Member',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Color(AppConfig.accentColor),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_outlined, color: Color(AppConfig.accentColor)),
            onPressed: () {
              // TODO: Handle edit profile
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Workouts',
            '12',
            Icons.fitness_center,
            Color(AppConfig.primaryColor),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Goals',
            '3',
            Icons.flag,
            Color(AppConfig.successColor),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            'Streak',
            '5',
            Icons.local_fire_department,
            Color(AppConfig.warningColor),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 100,
      borderRadius: 20,
      blur: 10,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(0.1),
          color.withOpacity(0.05),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(0.5),
          color.withOpacity(0.2),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(AppConfig.textColor),
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Color(AppConfig.secondaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(AppConfig.textColor),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                Icons.fitness_center,
                'My Workouts',
                Color(AppConfig.primaryColor),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildQuickActionCard(
                Icons.calendar_today,
                'Schedule',
                Color(AppConfig.successColor),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildQuickActionCard(
                Icons.analytics,
                'Progress',
                Color(AppConfig.warningColor),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(IconData icon, String label, Color color) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 100,
      borderRadius: 20,
      blur: 10,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(0.1),
          color.withOpacity(0.05),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(0.5),
          color.withOpacity(0.2),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(AppConfig.textColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Workout Settings',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(AppConfig.textColor),
          ),
        ),
        const SizedBox(height: 16),
        _buildSettingItem(
          Icons.speed,
          'Units',
          'Change measurement units',
          Color(AppConfig.primaryColor),
        ),
        _buildSettingItem(
          Icons.timer,
          'Rest Timer',
          'Set rest time between sets',
          Color(AppConfig.successColor),
        ),
        _buildSettingItem(
          Icons.music_note,
          'Workout Music',
          'Connect to music services',
          Color(AppConfig.warningColor),
        ),
      ],
    );
  }

  Widget _buildAppSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'App Settings',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(AppConfig.textColor),
          ),
        ),
        const SizedBox(height: 16),
        _buildToggleItem(
          Icons.dark_mode,
          'Dark Mode',
          'Switch between light and dark theme',
          _darkMode,
          Color(AppConfig.primaryColor),
          (value) {
            setState(() {
              _darkMode = value;
            });
          },
        ),
        _buildToggleItem(
          Icons.notifications,
          'Notifications',
          'Enable/disable workout reminders',
          _notifications,
          Color(AppConfig.successColor),
          (value) {
            setState(() {
              _notifications = value;
            });
          },
        ),
        _buildToggleItem(
          Icons.volume_up,
          'Sound Effects',
          'Enable/disable workout sounds',
          _soundEffects,
          Color(AppConfig.warningColor),
          (value) {
            setState(() {
              _soundEffects = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildAccountSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account & Support',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(AppConfig.textColor),
          ),
        ),
        const SizedBox(height: 16),
        _buildSettingItem(
          Icons.person_outline,
          'Profile',
          'Update your personal information',
          Color(AppConfig.primaryColor),
        ),
        _buildSettingItem(
          Icons.payment,
          'Membership',
          'Manage your gym membership',
          Color(AppConfig.successColor),
        ),
        _buildSettingItem(
          Icons.help_outline,
          'Help Center',
          'Get help with the app',
          Color(AppConfig.warningColor),
        ),
      ],
    );
  }

  Widget _buildSettingItem(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 80,
      margin: const EdgeInsets.only(bottom: 16),
      borderRadius: 20,
      blur: 10,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(0.1),
          color.withOpacity(0.05),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(0.5),
          color.withOpacity(0.2),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(AppConfig.textColor),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Color(AppConfig.secondaryColor),
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: Color(AppConfig.secondaryColor)),
        onTap: () {
          // TODO: Handle setting item tap
        },
      ),
    );
  }

  Widget _buildToggleItem(
    IconData icon,
    String title,
    String subtitle,
    bool value,
    Color color,
    ValueChanged<bool> onChanged,
  ) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 80,
      margin: const EdgeInsets.only(bottom: 16),
      borderRadius: 20,
      blur: 10,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(0.1),
          color.withOpacity(0.05),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withOpacity(0.5),
          color.withOpacity(0.2),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(AppConfig.textColor),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Color(AppConfig.secondaryColor),
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 60,
      borderRadius: 20,
      blur: 10,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(AppConfig.errorColor).withOpacity(0.1),
          Color(AppConfig.errorColor).withOpacity(0.05),
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(AppConfig.errorColor).withOpacity(0.5),
          Color(AppConfig.errorColor).withOpacity(0.2),
        ],
      ),
      child: TextButton(
        onPressed: () {
          // TODO: Handle logout
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: Color(AppConfig.errorColor)),
            const SizedBox(width: 8),
            Text(
              'Logout',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(AppConfig.errorColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
