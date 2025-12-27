import 'package:flutter/material.dart';

/// AppTheme - Centralized theme constants for enhanced screens
class AppTheme {
  // Primary Colors
  static const primaryColor = Color(0xFF6B73FF);
  static const secondaryColor = Color(0xFF000DFF);

  // Background Colors
  static const backgroundColor = Color(0xFFF5F5F5);
  static const cardColor = Colors.white;

  // Text Colors
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF666666);

  // Status Colors
  static const successColor = Color(0xFF4CAF50);
  static const errorColor = Color(0xFFF44336);
  static const warningColor = Color(0xFFFF9800);
  static const infoColor = Color(0xFF2196F3);

  // Gradients
  static const primaryGradient = LinearGradient(
    colors: [Color(0xFF6B73FF), Color(0xFF000DFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const successGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF45A049)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 20.0;

  // Shadows
  static BoxShadow primaryShadow = BoxShadow(
    color: primaryColor.withOpacity(0.3),
    blurRadius: 15,
    offset: const Offset(0, 8),
  );

  static BoxShadow cardShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 10,
    offset: const Offset(0, 2),
  );
}
