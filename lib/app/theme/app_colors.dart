// lib/app/theme/app_colors.dart

import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Palette
  static const Color lightBackground = Color(0xFFF5F5F7);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCardBg = Color(0xFFFFFFFF);
  static const Color lightCardGlass = Color(0xB2FFFFFF); // 0.7 opacity
  static const Color lightPrimary = Color(0xFF007AFF); // iOS blue
  static const Color lightSecondary = Color(0xFF34C759); // iOS green
  static const Color lightDanger = Color(0xFFFF3B30); // iOS red
  static const Color lightWarning = Color(0xFFFF9500); // iOS orange
  static const Color lightTextPrimary = Color(0xFF1C1C1E);
  static const Color lightTextSecondary = Color(0xFF6E6E73);
  static const Color lightTextTertiary = Color(0xFFAEAEB2);
  static const Color lightBorder = Color(0xFFE5E5EA);
  static const Color lightDivider = Color(0xFFD1D1D6);

  // Dark Theme Palette
  static const Color darkBackground = Color(0xFF000000); // OLED black
  static const Color darkSurface = Color(0xFF1C1C1E);
  static const Color darkCardBg = Color(0xFF1C1C1E);
  static const Color darkCardGlass = Color(0xB21C1C1E); // 0.7 opacity
  static const Color darkPrimary = Color(0xFF0A84FF); // iOS dark blue
  static const Color darkSecondary = Color(0xFF30D158); // iOS dark green
  static const Color darkDanger = Color(0xFFFF453A); // iOS dark red
  static const Color darkWarning = Color(0xFFFF9F0A); // iOS dark orange
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF8E8E93);
  static const Color darkTextTertiary = Color(0xFF636366);
  static const Color darkBorder = Color(0xFF38383A);
  static const Color darkDivider = Color(0xFF2C2C2E);

  // Category Colors (For Product Library representation)
  static const Map<String, Color> categories = {
    'Rice': Color(0xFFD4A574),        // Warm beige
    'Sugar': Color(0xFFE0F7FA),       // Sweet light cyan
    'Oil': Color(0xFFF4C430),         // Golden
    'Milk': Color(0xFFB3E5FC),        // Soft blue-white
    'Vegetables': Color(0xFF8BC34A),  // Green
    'Fruits': Color(0xFFFF7043),      // Orange-red
    'Dry Fruits': Color(0xFF8D6E63),  // Brown
    'Medicine': Color(0xFFEF5350),    // Red
    'Hardware': Color(0xFF78909C),    // Steel gray
    'Stationery': Color(0xFF5C6BC0),  // Indigo
    'Custom': Color(0xFFAB47BC),      // Purple
  };

  static Color getCategoryColor(String category) {
    return categories[category] ?? categories['Custom']!;
  }
}
