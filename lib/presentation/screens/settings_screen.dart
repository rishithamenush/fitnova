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

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileSection(),
                  const SizedBox(height: 24),
                  _buildWorkoutSettings(context),
                  const SizedBox(height: 24),
                  _buildAppSettings(context),
                  const SizedBox(height: 24),
                  _buildSupportSection(),
                  const SizedBox(height: 24),
                  _buildLogoutButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        centerTitle: true,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(AppConfig.primaryColor).withOpacity(0.1),
                Color(AppConfig.primaryColor).withOpacity(0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(AppConfig.primaryColor).withOpacity(0.5),
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                'assets/images/profile.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Color(AppConfig.primaryColor).withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Color(AppConfig.primaryColor),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rishitha Menusha',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Premium Member',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Color(AppConfig.primaryColor),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_outlined, color: Color(AppConfig.primaryColor)),
            onPressed: () {
              // TODO: Handle edit profile
            },
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildWorkoutSettings(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Workout Settings'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildRestTimeSetting(context, settings),
                  const Divider(height: 32),
                  _buildSettingItem(
                    icon: Icons.speed,
                    title: 'Units',
                    subtitle: 'Change measurement units',
                    onTap: () {
                      // TODO: Handle units setting
                    },
                  ),
                  const Divider(height: 32),
                  _buildSettingItem(
                    icon: Icons.music_note,
                    title: 'Workout Music',
                    subtitle: 'Connect to music services',
                    onTap: () {
                      // TODO: Handle music setting
                    },
                  ),
                ],
              ),
            ),
          ],
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideY(begin: 0.3, end: 0);
      },
    );
  }

  Widget _buildRestTimeSetting(BuildContext context, SettingsProvider settings) {
    return Column(
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
                color: Color(AppConfig.primaryColor).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${settings.restTime}s',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(AppConfig.primaryColor),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: Color(AppConfig.primaryColor),
            inactiveTrackColor: Color(AppConfig.primaryColor).withOpacity(0.2),
            thumbColor: Color(AppConfig.primaryColor),
            overlayColor: Color(AppConfig.primaryColor).withOpacity(0.1),
            valueIndicatorColor: Color(AppConfig.primaryColor),
            valueIndicatorTextStyle: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: Slider(
            value: settings.restTime.toDouble(),
            min: 0,
            max: 180,
            divisions: 36,
            label: '${settings.restTime}s',
            onChanged: (value) {
              settings.setRestTime(value.toInt());
            },
          ),
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
    );
  }

  Widget _buildAppSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('App Settings'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildToggleItem(
                icon: Icons.dark_mode,
                title: 'Dark Mode',
                subtitle: 'Switch between light and dark theme',
                value: false,
                onChanged: (value) {
                  // TODO: Handle dark mode
                },
              ),
              const Divider(height: 32),
              _buildToggleItem(
                icon: Icons.notifications,
                title: 'Notifications',
                subtitle: 'Enable/disable workout reminders',
                value: true,
                onChanged: (value) {
                  // TODO: Handle notifications
                },
              ),
              const Divider(height: 32),
              _buildToggleItem(
                icon: Icons.volume_up,
                title: 'Sound Effects',
                subtitle: 'Enable/disable workout sounds',
                value: true,
                onChanged: (value) {
                  // TODO: Handle sound effects
                },
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Support'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildSettingItem(
                icon: Icons.help_outline,
                title: 'Help Center',
                subtitle: 'Get help with the app',
                onTap: () {
                  // TODO: Handle help center
                },
              ),
              const Divider(height: 32),
              _buildSettingItem(
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'App version and information',
                onTap: () {
                  // TODO: Handle about
                },
              ),
              const Divider(height: 32),
              _buildSettingItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                subtitle: 'Read our privacy policy',
                onTap: () {
                  // TODO: Handle privacy policy
                },
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 600.ms, duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(AppConfig.primaryColor).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Color(AppConfig.primaryColor)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(AppConfig.primaryColor).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Color(AppConfig.primaryColor)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(AppConfig.primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton(
        onPressed: () {
          // TODO: Handle logout
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: Colors.red),
            const SizedBox(width: 8),
            Text(
              'Logout',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 800.ms, duration: 600.ms).slideY(begin: 0.3, end: 0);
  }
} 
