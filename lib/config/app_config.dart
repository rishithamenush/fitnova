class AppConfig {
  static const String appName = 'FiTNova';
  static const String appVersion = '1.0.0';

  // Database configuration
  static const String databaseName = 'fitnova.db';
  static const int databaseVersion = 1;

  // API configuration (if needed later)
  static const String baseUrl = 'https://api.fitnova.com';

  // Theme configuration
  // Modern fitness color palette
  static const primaryColor = 0xFF1E88E5; // Modern Blue
  static const secondaryColor = 0xFF42A5F5; // Light Blue
  static const accentColor = 0xFF64B5F6; // Sky Blue
  static const backgroundColor = 0xFFF5F7FA; // Light Gray Background
  static const surfaceColor = 0xFFFFFFFF; // White
  static const textColor = 0xFF1A1A1A; // Near Black
  static const errorColor = 0xFFE53935; // Error Red
  static const successColor = 0xFF43A047; // Success Green
  static const warningColor = 0xFFFFB300; // Warning Yellow

  // Gradient colors
  static const gradientStart = 0xFF1E88E5; // Modern Blue
  static const gradientEnd = 0xFF42A5F5; // Light Blue

  // Font families
  static const String primaryFont = 'Poppins';
  static const String secondaryFont = 'Montserrat';
} 