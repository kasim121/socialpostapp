import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 16,
    color: Color(0xFF9CA3AF), // Gray
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle airbnbCerealText({
    Color color = AppColors.grayShade, // Default color
    double fontSize = 20, // Default font size
    FontWeight fontWeight = FontWeight.w400, // Default font weight
  }) {
    return TextStyle(
      fontFamily: 'Airbnb Cereal App',
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    );
  }
}